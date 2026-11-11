# Repository conventions

The archive is a personal course collection, but it is maintained like a small
software project so that future-you (and anyone else) can find and run things.

## Layout

```
course-materials/
├── README.md                  # landing page and course table
├── docs/                      # cross-course documentation
├── R/                         # shared R helpers
├── tools/                     # repository checker
├── <Course>/                  # one folder per course or project
│   ├── README.md              # required course guide
│   ├── data/ | csv files/ | Data/
│   ├── code or notebooks
│   └── outputs/               # generated, git-ignored
└── 2025Spring/                # term folder for the Spring 2025 courses
```

Course folder names are deliberately **not** normalized (spaces, parentheses,
and course codes stay as they were). Renaming them would break external links
and old bookmarks; the documentation explains the names instead.

### Data folders

Data lives next to the code in one of the established names:

* `data/` — preferred for new material;
* `csv files/`, `Data/` — legacy names kept for the existing scripts;
* `data/external/` — cached public datasets with a source note.

Generated files (plots, PDFs, exported tables) go to `outputs/` and are ignored
by git. The `tools/check_repo.py` script warns about committed junk and broken
links, not about ignored outputs.

## Course README template

Every course folder has a `README.md` with:

1. **Overview** — course, term, and two or three sentences on the topic.
2. **What is inside** — a table or bullet list of the important files/folders.
3. **How to run it** — exact commands, or “no code” if it is document-only.
4. **Notes and caveats** — missing data and known issues.

The per-course READMEs are the source of truth for that course; the root
README and `docs/catalog.md` are indexes.

## Code style

### Python

* PEP 8, four-space indentation, type hints on public functions.
* `pathlib.Path` instead of string concatenation; no absolute local paths.
* A module docstring, a `main()` function, and `if __name__ == "__main__"`.
* `argparse` for command-line options; print a short usage line.
* Put reusable logic in a module; keep entry points thin (see
  `InfoNetworks/pythonCoauthorship/`).
* Avoid hard-coded API keys; read them from environment variables.

### R

* Keep the author/date/goal/data header block at the top of a script.
* Start with `source("_setup.R")` and use `read_data()` / `read_external()`.
* Never call `file.choose()` in committed code — pass an explicit filename.
* Never call `install.packages()` at runtime; use `require_packages()` so the
  error is actionable.
* Use `robust_summary(model)` instead of `summary(model, robust = TRUE)`.
* Prefer `<-` for assignment and explicit `data =` arguments.
* Scripts should run from their own folder with `Rscript script.R`.

### Julia

* One `Project.toml` per runnable project.
* Homework notebooks may stay in Pluto format; plain source belongs in `src/`.
* Keep `using` statements at the top of the first cell/module.
* Pin only major versions in `[compat]`; let `Pkg.instantiate()` resolve the
  rest.

### SQL

* Include DDL, a loading command, and labelled queries.
* Use relative paths with `\copy`; do not depend on a server-side file path.
* Comment the intent of each query and order results deterministically.

### Notebooks

* Keep a valid `kernelspec` in metadata.
* Read data through relative paths; resolve a course data folder at the top.
* Do not clear outputs from submitted work unless they are misleading; if code
  changes, re-run or add a note.
* No secrets in cells, outputs, or tracebacks.

## Documentation style

* Markdown, one `#` heading per document, sentence case for headings.
* Prefer tables for file/data inventories and short paragraphs elsewhere.
* Use relative links for files in this repository; use angle brackets or
  `%20` for paths with spaces.
* Explain *why* a file matters, not just its name.
* Keep line length reasonable (no hard limit, but avoid wall-of-text tables).

## Data policy

* Record the source and license of any dataset you add, ideally in a small
  `README.md` next to it.
* Do not add human-subjects data, grades, student IDs, private correspondence,
  or anything you would not put on a public web page.
* Prefer small CSV/JSON extracts over large binaries; use `.gitignore` for
  generated files.
* If a file is larger than ~25 MB, open an issue before committing it.
* For public datasets, cache the response under `data/external/` and record the
  URL and download date.

## Commits and history

Use short, imperative commit messages, optionally with a Conventional Commits
prefix:

```
docs: add per-course READMEs
fix(r): replace file.choose with explicit data paths
chore: remove duplicate archives and OS junk
feat(info-networks): refactor coauthorship analysis into a module
```

Before committing:

```bash
make check
git status --short
git diff --check
```

History rewrites are reserved for removing secrets or sensitive personal data
(see [`security.md`](security.md)); ordinary cleanups add a new commit.

## Adding a new course

1. Create the folder with the course name or code.
2. Add a `README.md` from the template above.
3. Put data in `data/` and code next to it; add a `Project.toml`,
   `requirements.txt`, or `renv` note if needed.
4. Run `make check` and fix warnings that apply.
5. Add the course to the root README table and `docs/catalog.md`.
