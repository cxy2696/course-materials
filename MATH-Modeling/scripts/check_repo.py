#!/usr/bin/env python3
"""Repository self-check for MATH-Modeling.

Runs offline with the Python standard library only.

Checks
------
1. Every notebook is valid nbformat 4 JSON with a Python kernel.
2. Every relative link in every Markdown file resolves to an existing path.
3. Data files referenced from notebook code exist on disk (relative paths only).
4. No accidental duplicate files (identical SHA-256) and no empty files.
5. No editor/OS junk is tracked (``.DS_Store``, ``.ipynb_checkpoints``, ...).

Usage
-----
    python scripts/check_repo.py           # human-readable report
    python scripts/check_repo.py --strict  # treat warnings as errors

Exit status: 0 when no errors were found, 1 otherwise.
"""

from __future__ import annotations

import argparse
import hashlib
import json
import os
import re
import sys
from collections import defaultdict
from pathlib import Path
from urllib.parse import unquote, urlsplit

ROOT = Path(__file__).resolve().parent.parent

SKIP_DIRS = {".git", ".venv", "venv", "__pycache__", ".ipynb_checkpoints", ".idea", ".vscode"}
JUNK_NAMES = {".DS_Store", "Thumbs.db", "desktop.ini"}

LINK_RE = re.compile(r"!?\[[^\]]*\]\((?:<([^>]+)>|([^)\s]+))\)")
NOTEBOOK_DATA_RE = re.compile(
    r"""(?:read_csv|read_excel|read_table|read_json|genfromtxt|loadtxt|imread|open)\s*\(\s*['"]([^'"]+)['"]"""
)
MARKDOWN_SUFFIXES = {".md", ".markdown"}


class Report:
    def __init__(self) -> None:
        self.errors: list[str] = []
        self.warnings: list[str] = []
        self.notes: list[str] = []

    def error(self, message: str) -> None:
        self.errors.append(message)

    def warning(self, message: str) -> None:
        self.warnings.append(message)

    def note(self, message: str) -> None:
        self.notes.append(message)


def iter_repo_files() -> list[Path]:
    files: list[Path] = []
    for dirpath, dirnames, filenames in os.walk(ROOT):
        dirnames[:] = sorted(d for d in dirnames if d not in SKIP_DIRS)
        for name in sorted(filenames):
            files.append(Path(dirpath) / name)
    return files


def rel(path: Path) -> str:
    return path.relative_to(ROOT).as_posix()


def check_junk(files: list[Path], report: Report) -> None:
    for path in files:
        if path.name in JUNK_NAMES or ".ipynb_checkpoints" in path.parts:
            report.error(f"junk file in tree: {rel(path)}")


def check_empty_files(files: list[Path], report: Report) -> None:
    for path in files:
        if path.stat().st_size == 0:
            report.error(f"empty file: {rel(path)}")


def check_duplicates(files: list[Path], report: Report) -> None:
    by_hash: dict[str, list[Path]] = defaultdict(list)
    for path in files:
        digest = hashlib.sha256()
        with path.open("rb") as handle:
            for chunk in iter(lambda: handle.read(1 << 20), b""):
                digest.update(chunk)
        by_hash[digest.hexdigest()].append(path)
    for paths in by_hash.values():
        if len(paths) > 1:
            report.warning("identical files: " + ", ".join(rel(p) for p in paths))


def check_notebooks(files: list[Path], report: Report) -> dict[Path, dict]:
    notebooks = [p for p in files if p.suffix == ".ipynb"]
    parsed: dict[Path, dict] = {}
    for path in notebooks:
        try:
            data = json.loads(path.read_text(encoding="utf-8"))
        except (UnicodeDecodeError, json.JSONDecodeError) as exc:
            report.error(f"invalid notebook JSON: {rel(path)} ({exc})")
            continue
        parsed[path] = data
        if data.get("nbformat") != 4:
            report.error(f"unsupported nbformat in {rel(path)}: {data.get('nbformat')!r}")
            continue
        cells = data.get("cells")
        if not isinstance(cells, list) or not cells:
            report.error(f"notebook has no cells: {rel(path)}")
            continue
        for index, cell in enumerate(cells):
            if cell.get("cell_type") not in {"code", "markdown", "raw"}:
                report.error(f"{rel(path)}: cell {index} has invalid type")
            if cell.get("cell_type") == "code" and "outputs" not in cell:
                report.error(f"{rel(path)}: code cell {index} has no outputs list")
        kernel = data.get("metadata", {}).get("kernelspec", {})
        name = kernel.get("name", "")
        language = kernel.get("language", "")
        if name != "python3" or language not in {"", "python"}:
            report.warning(
                f"{rel(path)}: kernel is {name!r}/{language!r}, expected python3"
            )
        if not data.get("metadata", {}).get("language_info"):
            report.warning(f"{rel(path)}: missing language_info metadata")
    report.note(f"notebooks checked: {len(notebooks)}")
    return parsed


def iter_markdown_links(path: Path):
    text = path.read_text(encoding="utf-8")
    # Drop fenced code blocks so example links in code are ignored.
    text = re.sub(r"```.*?```", "", text, flags=re.S)
    for match in LINK_RE.finditer(text):
        destination = match.group(1) or match.group(2) or ""
        yield destination.strip()


def check_markdown_links(files: list[Path], report: Report) -> None:
    count = 0
    for path in files:
        if path.suffix.lower() not in MARKDOWN_SUFFIXES:
            continue
        for destination in iter_markdown_links(path):
            if not destination:
                continue
            parts = urlsplit(destination)
            if parts.scheme or parts.netloc or destination.startswith("#"):
                continue
            if destination.startswith("mailto:") or destination.startswith("tel:"):
                continue
            target = unquote(parts.path)
            if not target:
                continue
            resolved = (path.parent / target).resolve()
            try:
                resolved.relative_to(ROOT)
            except ValueError:
                # The folder can also live inside the course-materials archive,
                # where ../README.md and sibling course folders are valid.
                if resolved.exists():
                    count += 1
                    continue
                report.error(f"{rel(path)}: link escapes the repository: {destination}")
                continue
            count += 1
            if not resolved.exists():
                report.error(f"{rel(path)}: broken link -> {destination}")
    report.note(f"relative markdown links checked: {count}")


def check_notebook_data_paths(files: list[Path], report: Report, parsed: dict[Path, dict]) -> None:
    count = 0
    for path in files:
        if path.suffix != ".ipynb":
            continue
        data = parsed.get(path)
        if data is None:
            continue
        for cell in data.get("cells", []):
            if cell.get("cell_type") != "code":
                continue
            source = "".join(cell.get("source", []))
            for raw in NOTEBOOK_DATA_RE.findall(source):
                if raw.startswith(("http://", "https://", "data:", "\\")):
                    continue
                if raw.startswith("/") or "\\" in raw or re.match(r"^[A-Za-z]:", raw):
                    report.warning(f"{rel(path)}: absolute path in code: {raw}")
                    continue
                candidate = (path.parent / raw).resolve()
                count += 1
                if not candidate.exists():
                    report.error(f"{rel(path)}: data file not found -> {raw}")
    report.note(f"local data references checked: {count}")


def check_layout(report: Report) -> None:
    required = [
        "README.md",
        "requirements.txt",
        "notebooks",
        "homework",
        "modeling",
        "projects",
        "references",
        "data",
        "docs",
        "scripts",
    ]
    for name in required:
        if not (ROOT / name).exists():
            report.error(f"required path missing: {name}")


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--strict", action="store_true", help="treat warnings as errors")
    args = parser.parse_args()

    report = Report()
    files = iter_repo_files()
    check_layout(report)
    check_junk(files, report)
    check_empty_files(files, report)
    parsed = check_notebooks(files, report)
    check_markdown_links(files, report)
    check_notebook_data_paths(files, report, parsed)
    check_duplicates(files, report)

    for message in report.notes:
        print(f"note: {message}")
    for message in report.warnings:
        print(f"warning: {message}")
    for message in report.errors:
        print(f"error: {message}", file=sys.stderr)

    print(
        f"\n{len(files)} files, {len(report.errors)} errors, "
        f"{len(report.warnings)} warnings"
    )
    if report.errors or (args.strict and report.warnings):
        return 1
    print("OK")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
