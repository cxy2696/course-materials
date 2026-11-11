#!/usr/bin/env python3
"""Repository hygiene checks for the course-materials archive.

The script is intentionally dependency-free (standard library only) so it can
run in CI and in a fresh checkout:

    python3 tools/check_repo.py

Checks:
  * tracked junk files (``.DS_Store``, Office lock files, checkpoints)
  * accidentally committed secrets (API keys, tokens, private keys)
  * notebook JSON validity and missing kernelspec information
  * Python syntax (``ast.parse``)
  * R syntax via ``Rscript`` when available
  * Julia syntax via ``julia`` when available
  * relative Markdown links and images
  * hard-coded local absolute paths in code and notebooks

Exit status is 1 when an error is found; warnings do not fail the run.
"""

from __future__ import annotations

import argparse
import ast
import json
import os
import re
import subprocess
import sys
import tempfile
from pathlib import Path
from urllib.parse import unquote

ROOT = Path(__file__).resolve().parents[1]
TEXT_SUFFIXES = {
    ".md", ".py", ".R", ".r", ".jl", ".ipynb", ".sql", ".pgsql", ".toml",
    ".yml", ".yaml", ".txt", ".csv", ".json", ".cff", ".tex", ".sty", ".html",
    ".css", ".js",
}
CODE_SUFFIXES = {".py", ".R", ".r", ".jl", ".ipynb"}

SECRET_PATTERNS = [
    ("Google API key", re.compile(r"AIza[0-9A-Za-z_-]{30,}")),
    ("GitHub token", re.compile(r"gh[pousr]_[A-Za-z0-9]{30,}")),
    ("OpenAI-style key", re.compile(r"sk-[A-Za-z0-9]{32,}")),
    ("AWS access key", re.compile(r"AKIA[0-9A-Z]{16}")),
    ("Slack token", re.compile(r"xox[baprs]-[A-Za-z0-9-]{10,}")),
    ("private key", re.compile(r"-----BEGIN (?:RSA |OPENSSH |EC )?PRIVATE KEY-----")),
]
SECRET_ALLOW = (
    "os.getenv", "os.environ", "Sys.getenv", "process.env", "your_", "your-",
    "example", "placeholder", "redacted", "xxxx", "<key", "api_key = ''",
    'api_key = ""', "REPLACE_ME", "INSERT_",
)

JUNK_NAMES = {".DS_Store", "Thumbs.db", "desktop.ini"}
JUNK_PARTS = {".ipynb_checkpoints", "__MACOSX"}
JUNK_PREFIXES = ("~$", "._")

ABSOLUTE_PATH = re.compile(r"(?:/Users/[^/\s]+/|/home/[^/\s]+/|[A-Za-z]:\\\\)")
MARKDOWN_LINK = re.compile(r"!?\[[^\]]*\]\(\s*(<[^>]+>|[^\s)]+)(?:\s+\"[^\"]*\")?\s*\)")
HTML_LINK = re.compile(r"(?:src|href)=\"([^\"]+)\"")


def tracked_files() -> list[Path]:
    try:
        output = subprocess.run(
            ["git", "-C", str(ROOT), "ls-files", "-z"],
            check=True, capture_output=True,
        ).stdout
        names = [item for item in output.decode("utf-8", "replace").split("\0") if item]
        if names:
            return [ROOT / name for name in names]
    except (OSError, subprocess.CalledProcessError):
        pass
    return [
        path for path in ROOT.rglob("*")
        if path.is_file() and ".git" not in path.parts
    ]


def read_text(path: Path) -> str:
    try:
        return path.read_text(encoding="utf-8", errors="replace")
    except OSError:
        return ""


def rel(path: Path) -> str:
    return path.relative_to(ROOT).as_posix()


def check_junk(files: list[Path], errors: list[str]) -> None:
    for path in files:
        name = path.name
        if name in JUNK_NAMES or name.startswith(JUNK_PREFIXES) or any(part in JUNK_PARTS for part in path.parts):
            errors.append(f"junk file is tracked: {rel(path)}")


def scan_text(path: Path) -> str:
    """Return the text to scan for secrets.

    For notebooks, only cell source and textual outputs are scanned; embedded
    PNG/JPEG/PDF payloads are base64 noise and produce false positives (an
    ``AIza`` substring can occur by chance in a compressed image).
    """
    if path.suffix != ".ipynb":
        return read_text(path)
    try:
        notebook = json.loads(read_text(path))
    except json.JSONDecodeError:
        return ""
    chunks: list[str] = []
    for cell in notebook.get("cells", []):
        chunks.append("".join(cell.get("source", [])))
        for output in cell.get("outputs", []):
            if output.get("output_type") == "stream":
                text = output.get("text", "")
                chunks.append("".join(text) if isinstance(text, list) else str(text))
            elif output.get("output_type") == "error":
                chunks.append(str(output.get("evalue", "")))
                chunks.append("".join(output.get("traceback", [])))
            else:
                for mime, value in output.get("data", {}).items():
                    if mime.startswith("text/") or mime == "application/json":
                        chunks.append("".join(value) if isinstance(value, list) else str(value))
    return "\n".join(chunks)


def check_secrets(files: list[Path], errors: list[str]) -> None:
    for path in files:
        if path.suffix.lower() not in TEXT_SUFFIXES or path.stat().st_size > 2_000_000:
            continue
        text = scan_text(path)
        for lineno, line in enumerate(text.splitlines(), 1):
            if any(token.lower() in line.lower() for token in SECRET_ALLOW):
                continue
            for label, pattern in SECRET_PATTERNS:
                if pattern.search(line):
                    errors.append(f"{label} in {rel(path)}:{lineno}")
                    break


def check_notebooks(files: list[Path], errors: list[str], warnings: list[str]) -> None:
    for path in files:
        if path.suffix != ".ipynb":
            continue
        try:
            notebook = json.loads(read_text(path))
        except json.JSONDecodeError as exc:
            errors.append(f"invalid notebook JSON: {rel(path)} ({exc})")
            continue
        if not isinstance(notebook.get("cells"), list):
            errors.append(f"notebook has no cells list: {rel(path)}")
            continue
        if not notebook.get("metadata", {}).get("kernelspec"):
            warnings.append(f"notebook has no kernelspec: {rel(path)}")
        for index, cell in enumerate(notebook["cells"]):
            if cell.get("cell_type") not in {"code", "markdown", "raw"}:
                warnings.append(f"unknown cell type in {rel(path)} cell {index}")


def check_python(files: list[Path], errors: list[str]) -> None:
    for path in files:
        if path.suffix != ".py":
            continue
        try:
            ast.parse(read_text(path), filename=str(path))
        except SyntaxError as exc:
            errors.append(f"Python syntax error: {rel(path)}:{exc.lineno}: {exc.msg}")


def check_r(files: list[Path], errors: list[str]) -> None:
    r_files = [str(path) for path in files if path.suffix in {".R", ".r"}]
    if not r_files:
        return
    script = """files <- strsplit(Sys.getenv("CHECK_R_FILES"), "\\n", fixed = TRUE)[[1]]
bad <- character()
for (f in files) {
  ok <- tryCatch({ parse(f); TRUE }, error = function(e) {
    cat("PARSE", f, ":", conditionMessage(e), "\\n")
    FALSE
  })
  if (!ok) bad <- c(bad, f)
}
if (length(bad) > 0) quit(status = 1)
"""
    env = dict(os.environ, CHECK_R_FILES="\n".join(r_files))
    try:
        result = subprocess.run(
            ["Rscript", "--vanilla", "-e", script],
            env=env, cwd=ROOT, capture_output=True, text=True, timeout=180,
        )
    except (FileNotFoundError, subprocess.TimeoutExpired) as exc:
        print(f"warning: skipped R syntax check ({exc})")
        return
    if result.returncode != 0:
        detail = (result.stdout + result.stderr).strip().splitlines()
        errors.extend(f"R syntax: {line}" for line in detail if line.startswith("PARSE"))


def check_julia(files: list[Path], errors: list[str]) -> None:
    jl_files = [str(path) for path in files if path.suffix == ".jl"]
    if not jl_files:
        return
    script = (
        'bad = String[]; for f in ARGS; try; Meta.parseall(read(f, String)); '
        'catch e; println("PARSE ", f, " : ", e); push!(bad, f); end; end; '
        'isempty(bad) || exit(1)'
    )
    try:
        result = subprocess.run(
            ["julia", "--startup-file=no", "-e", script, *jl_files],
            cwd=ROOT, capture_output=True, text=True, timeout=240,
        )
    except (FileNotFoundError, subprocess.TimeoutExpired) as exc:
        print(f"warning: skipped Julia syntax check ({exc})")
        return
    if result.returncode != 0:
        detail = (result.stdout + result.stderr).strip().splitlines()
        errors.extend(f"Julia syntax: {line}" for line in detail if line.startswith("PARSE"))


def check_markdown_links(files: list[Path], errors: list[str]) -> None:
    for path in files:
        if path.suffix.lower() != ".md":
            continue
        text = read_text(path)
        links = MARKDOWN_LINK.findall(text) + HTML_LINK.findall(text)
        for link in links:
            target = link.strip().strip("<>")
            if not target or target.startswith(("#", "http://", "https://", "mailto:", "tel:", "data:")):
                continue
            target = unquote(target.split("#", 1)[0])
            if not target:
                continue
            candidate = (path.parent / target).resolve()
            if not candidate.exists():
                errors.append(f"broken relative link in {rel(path)}: {target}")


def check_absolute_paths(files: list[Path], warnings: list[str]) -> None:
    for path in files:
        if path.suffix.lower() not in CODE_SUFFIXES or path.suffix == ".ipynb":
            continue
        if path == Path(__file__).resolve():
            continue
        text = read_text(path)
        for lineno, line in enumerate(text.splitlines(), 1):
            if ABSOLUTE_PATH.search(line):
                warnings.append(f"absolute path in {rel(path)}:{lineno}")
    for path in files:
        if path.suffix != ".ipynb":
            continue
        try:
            notebook = json.loads(read_text(path))
        except json.JSONDecodeError:
            continue
        for index, cell in enumerate(notebook.get("cells", [])):
            if cell.get("cell_type") != "code":
                continue
            for lineno, line in enumerate("".join(cell.get("source", [])).splitlines(), 1):
                if ABSOLUTE_PATH.search(line):
                    warnings.append(f"absolute path in {rel(path)} cell {index} line {lineno}")


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    parser.add_argument("--skip-code", action="store_true", help="skip R/Julia parse checks")
    args = parser.parse_args()

    files = tracked_files()
    errors: list[str] = []
    warnings: list[str] = []

    check_junk(files, errors)
    check_secrets(files, errors)
    check_notebooks(files, errors, warnings)
    check_python(files, errors)
    if not args.skip_code:
        check_r(files, errors)
        check_julia(files, errors)
    check_markdown_links(files, errors)
    check_absolute_paths(files, warnings)

    print(f"Checked {len(files):,} tracked files.")
    for warning in warnings:
        print(f"warning: {warning}")
    for error in errors:
        print(f"error: {error}")
    print(f"\n{len(errors)} error(s), {len(warnings)} warning(s).")
    return 1 if errors else 0


if __name__ == "__main__":
    sys.exit(main())
