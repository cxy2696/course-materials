# Changelog

I log the bigger passes over this repo here. Small fixes just live in the commit
history.

## 2026-11-12 — cleanup, merges, and a documentation pass

This started as a tidy-up and turned into three merges: the old `code` archive,
the `MATH-Modeling` archive, and a rewrite of the docs in my own voice.

### Documentation

- Rewrote the root README and the course READMEs as personal notes in first
  person, without the project-page framing.
- Added `docs/`: catalog, running guide, conventions, data/privacy, security,
  and notes on the two merged repositories.
- Added `LICENSE`, `.editorconfig`, `.gitattributes`, `.gitignore`, and the
  checker config.
- Removed `CONTRIBUTING.md`, `CITATION.cff`, the third-party-material page, and
  the root `SECURITY.md`. The key note is in `docs/security.md`; this is a
  personal record, not a project page.

### Reproducibility

- Replaced `file.choose()` in the R scripts with explicit data paths.
- Added `R/course_utils.R` and the per-course `_setup.R` wrappers:
  `read_data()`, `read_external()`, `require_packages()`, and
  `robust_summary()`.
- Cached five public datasets in `Applied-Statistics/data/external/`.
- Added `Matrix Computations/Project.toml` and the `bo-tutorial` project file.
- Added root `requirements.txt`, `requirements-ai.txt`, and the exercise
  requirements.
- Made the SQL lab portable: DDL, a relative `\copy`, and ten labelled queries.
- Gave the numerical-analysis notebooks one `data/` folder instead of Windows
  paths and remote image URLs.

### Fixes

- Fixed the coauthorship parser that mixed bibliography metadata into author
  names. The graph went from an inflated 85k nodes to 32,451 nodes / 96,755
  edges, and I regenerated the outputs.
- Fixed the undefined `pdata` object in the panel-data script and the invalid R
  default argument in `Thesis.R`.
- Replaced `summary(model, robust = TRUE)` with `robust_summary()` (HC1). The
  old calls were silently ignored by base R, so some old reports show
  conventional standard errors.
- Fixed the market-design Python notebook, which imported an R package from
  Python. It now uses a pure-Python deferred-acceptance implementation and
  matches the R averages.
- Fixed the notebook secret scanner so base64 plot images don't look like API
  keys.

### Merges

- Folded in the `code` archive: CSCI 161 Java labs, Machine Learning
  assignments, MITx 6.00.1x, INFO 4100 R setup, C++, practice notebooks, the
  creative project, and the HNL voter model. See `docs/code-merge.md`.
- Folded in `MATH-Modeling`: 74 notebooks, eight problem sets, modeling notes,
  references, and a cross-entropy project. See `docs/math-modeling.md`.
- Added Java/C++/Python test targets and a CI job for the merged code.

### Removed

- The leaked Google API key from `exercises/questions.ipynb`. It is still in
  history; see `docs/security.md`.
- 16 tracked `.DS_Store` files, two Office lock files, and notebook checkpoints.
- Exact duplicates: `Category Theory/.../BCT.pdf`,
  `BUS435/ClassNotes/Case_ Can the Eurozone survive2.pdf`, a duplicate Statista
  workbook, `AI in Organizations/hw4/docs.zip`, and a redundant audio archive.
- Duplicate root copies of two numerical-analysis notebooks.
- The scratch `2025Spring/6220/Assignment/test.R`.

### Still open

- The “roots” dataset used by several `Applied-Statistics` effect-size scripts
  never came with the course. The scripts stop and tell me what's missing.
- `ECON284/Ed.R` needs `ECON284_DISTANCE_DATA`.
- The API key is still in git history. Revoking it matters more than rewriting
  the history.
- The repo is large: hundreds of MB of PDFs, plus the MATH-Modeling reference
  books. I don't use Git LFS.
- Notebook outputs are from the original runs. I re-run a notebook if I change
  its code.
