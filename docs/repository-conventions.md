# How I keep these notes

I'm not running a project for other people. These habits just keep the folders
usable; otherwise I forget where things are and broken paths pile up.

## Where things go

```
course-materials/
├── README.md
├── docs/
├── R/
├── tools/
├── <Course>/
│   ├── README.md
│   ├── data/ | csv files/ | Data/
│   ├── code or notebooks
│   └── outputs/               # generated, ignored by git
└── 2025Spring/
```

I leave old course folder names alone, even when they have spaces or
parentheses. Too many links point at them.

Data sits next to the code in `data/`, `csv files/`, or `Data/`, depending on
what the course used. Generated plots go in `outputs/`, which git ignores.

## Course READMEs

Each folder has a short `README.md` that tells me:

1. what the course was and when I took it;
2. what I actually did in the folder;
3. how to run the code, if there is any;
4. what's missing or worth remembering.

The root README and `docs/catalog.md` are just indexes.

## Code habits

- Paths are relative. No `/Users/...` or `C:\...`.
- No keys in code, notebooks, comments, or outputs.
- Python: `pathlib`, a `main()`, and `argparse` for anything with options.
- R: start with `source("_setup.R")`, use `read_data()`, and use
  `robust_summary()` instead of `summary(..., robust = TRUE)`.
- Julia: one `Project.toml` per runnable project.
- SQL: include the DDL and use a relative `\copy`.
- Notebooks: keep the `kernelspec`, read data through relative paths, and don't
  clear outputs from a submitted notebook unless I re-run it.

## Data

- Note where a dataset came from and what its terms are.
- No human-subjects data, grades, student IDs, or private email.
- Prefer a small CSV/JSON over a large binary.
- Public data I download once goes in `data/external/` with the URL and date.

## Before I push

```bash
make check
git status --short
git diff --check
```

I only rewrite history when I'm removing a secret or personal data.

## Adding a course

1. Make a folder with the course name or code.
2. Write a short `README.md` along the lines above.
3. Put data in `data/` and code next to it.
4. Run `make check`.
5. Add it to the root README and `docs/catalog.md`.
