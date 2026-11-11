# How I keep this repo

It's a personal course archive, but I treat it like a small project. Otherwise I
forget where things are, and broken paths pile up.

## Folders

```
course-materials/
├── README.md                  # the main index
├── docs/                      # notes that apply to every course
├── R/                         # helpers the R scripts share
├── tools/                     # repo checker
├── <Course>/                  # one folder per course or project
│   ├── README.md
│   ├── data/ | csv files/ | Data/
│   ├── code or notebooks
│   └── outputs/               # generated, ignored by git
└── 2025Spring/                # term folder for the Spring 2025 courses
```

I don't rename old course folders, even when they have spaces or parentheses.
Too many links and notes point at them; the READMEs explain the names instead.

Data sits next to the code in `data/`, `csv files/`, or `Data/`, depending on
what the course used. `data/external/` is for public datasets I downloaded once.
Generated plots go in `outputs/`, which git ignores.

## Course READMEs

Each folder has a `README.md` that answers four things:

1. What the course was and when I took it.
2. What I actually did in the folder.
3. How to run the code, if there is any.
4. What is missing or worth knowing before you reuse it.

The course README is the source of truth. The root README and
`docs/catalog.md` are just indexes.

## Code

### Python

- Four-space indentation and type hints on public functions.
- `pathlib` instead of string paths; no `/Users/...` or `C:\...`.
- A module docstring, a `main()`, and `if __name__ == "__main__"`.
- `argparse` for command-line options.
- Reusable logic in a module, thin entry points
  (see `InfoNetworks/pythonCoauthorship/`).
- Keys come from environment variables, never from the code.

### R

- Keep the author/date/goal/data header at the top of a script.
- Start with `source("_setup.R")` and use `read_data()` or `read_external()`.
- No `file.choose()` in committed code; pass an explicit filename.
- No `install.packages()` at runtime; `require_packages()` gives a useful error
  instead.
- Use `robust_summary(model)` rather than `summary(model, robust = TRUE)`,
  which base R silently ignores.
- The script should run from its own folder with `Rscript script.R`.

### Julia

- One `Project.toml` per runnable project.
- Pluto is fine for homework; plain source goes in `src/`.
- Keep `using` statements at the top.

### SQL

- Include the DDL, the data load, and labelled queries.
- Use a relative `\copy` path, not a server-side absolute path.
- Order results deterministically when you print them.

### Notebooks

- Keep a valid `kernelspec`.
- Read data through relative paths.
- Don't clear outputs from submitted work unless the code changed; then either
  re-run or say so in the README.
- No keys in cells, outputs, or tracebacks.

## Data

- Record where a dataset came from and its license, ideally next to the data.
- Don't add human-subjects data, grades, student IDs, or private correspondence.
- Prefer a small CSV or JSON extract over a large binary.
- If a file is over ~25 MB, think about whether it needs to be in git at all.
- If I download a public dataset, I put it in `data/external/` with the URL and
  download date.

## Commits

Short, imperative messages. Sometimes with a prefix:

```
docs: rewrite the course notes in first person
fix(r): replace file.choose with explicit data paths
chore: remove duplicate archives and OS junk
feat(info-networks): refactor coauthorship analysis into a module
```

Before pushing:

```bash
make check
git status --short
git diff --check
```

I only rewrite history when I'm removing a secret or personal data. Normal
cleanups get a new commit.

## Adding a course

1. Make a folder with the course name or code.
2. Write a `README.md` using the four points above.
3. Put data in `data/` and code next to it.
4. Run `make check`.
5. Add the folder to the root README and `docs/catalog.md`.
