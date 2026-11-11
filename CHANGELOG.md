# Changelog

All notable changes to this archive are recorded here. The format is loosely
based on [Keep a Changelog](https://keepachangelog.com/).

## 2026-11-12 — repository refresh

A full pass over organization, documentation, reproducibility, and correctness.
No course content was rewritten; the changes are cleanup, fixes, and guides.

### Added

* Root README with a course table, highlights, setup pointers, and a summary of
  the cleanup.
* Per-course READMEs for all 17 course/project folders.
* `docs/`: catalog, running guide, repository conventions, data/privacy,
  third-party materials, and the security incident.
* `CONTRIBUTING.md`, `CITATION.cff`, `LICENSE`, `.editorconfig`,
  `.gitattributes`, `.gitignore`.
* `requirements.txt`, `requirements-ai.txt`, and `exercises/requirements.txt`.
* Merged coursework from the separate `code` archive: `CSCI 161` Java labs,
  five `Machine Learning` assignments, `MITx 6.00.1x`, `INFO 4100` R setup,
  `Practice Notebooks`, `Creative Project (CS 3780-5780)`, a C++ example, and
  the HNL voter model under `InfoNetworks`.
* Python/Java/C++ test targets (`make check-code`) and a CI job for the merged
  code.
* `R/course_utils.R` plus per-course `_setup.R` wrappers (`read_data`,
  `read_external`, `require_packages`, `robust_summary`).
* `Matrix Computations/Project.toml` and
  `Matrix Computations/bo-tutorial/Project.toml`.
* Cached public datasets in `Applied-Statistics/data/external/`.
* `tools/check_repo.py`, `Makefile`, and a GitHub Actions quality workflow.

### Changed

* `Applied-Statistics` scripts now use explicit dataset paths instead of
  `file.choose()`; remote statsci.org reads use the cached files.
* `summary(model, robust = TRUE)` calls across the R scripts were replaced with
  `robust_summary()` (HC1 standard errors). Results can differ from the original
  reports, which used base-R standard errors.
* `ECON284` scripts load their datasets by name; `ECON411` and
  `mobile-RPG-observation` load `rpgObservation.CSV` explicitly.
* `2025Spring/6220/Assignment` scripts were cleaned up: one seed, no runtime
  `install.packages()`, and the shadowed loop variable was renamed.
* `2025Spring/6220/Assignment/A2.ipynb` was rewritten as a working pure-Python
  deferred-acceptance implementation (the original imported the R package
  `matchingMarkets` from Python and failed). Its averages match the R version.
* `InfoNetworks/pythonCoauthorship` was refactored into a reusable module with a
  CLI. The parser now reads year/venue/author fields explicitly, so single-author
  metadata no longer leaks into author names. Records without a citation count
  are accepted; the graph is 34,259 nodes / 96,582 edges and outputs were
  regenerated. The duplicated `ps1data.txt` in the custom-BFS folder was removed;
  both entry points share the file in `pythonCoauthorship/`.
* `InfoNetworks/pythonCoauthorship_customBFStree/test.py` became
  `custom_bfs.py`, a thin wrapper around the shared module.
* `BUS435/CoursePack/AIFS Hedge Strategy.py` became
  `BUS435/CoursePack/aifs_hedge_strategy.py`, with typed data classes and a
  `main()`; the numbers are unchanged.
* `ECON411/Poster pictures/data.py` is now an honest, documented parser for a
  saved page (the live site is Cloudflare-protected).
* `CS_5320/SQLfolder/bars.pgsql` now has DDL, a relative `\copy`, and ten
  labelled queries.
* Numerical-analysis notebooks use one `data/` folder instead of Windows paths
  and remote GitHub/cocalc URLs. Missing kernelspecs were added.
* The exercises notebook now reads `GEMINI_API_KEY` from the environment and
  cleans ORCID values without assuming the real 12-digit format. Its stale
  outputs were cleared when the key was removed.
* Added a root `SECURITY.md` reporting policy.
* The `exercises` folder was flattened from `exercises/exercises/` to
  `exercises/`.

### Removed

* The leaked Google API key from `exercises/questions.ipynb` (still in history;
  revoke it — see `docs/security.md`).
* 16 tracked `.DS_Store` files, two Office lock files, and notebook checkpoints.
* Exact duplicates: `Category Theory/.../BCT.pdf`,
  `BUS435/ClassNotes/Case_ Can the Eurozone survive2.pdf`, a duplicate Statista
  workbook, `AI in Organizations/hw4/docs.zip`, and the redundant audio archive.
* Duplicate root copies of two numerical-analysis notebooks.
* The scratch `2025Spring/6220/Assignment/test.R`.

### Known issues

* The “roots” dataset used by several `Applied-Statistics` effect-size scripts
  is not included; the scripts fail with instructions.
* `ECON284/Ed.R` needs `ECON284_DISTANCE_DATA`.
* Notebook outputs are retained from the original runs; re-run a notebook after
  changing its code.
* The repository is still large (hundreds of MB of PDFs); Git LFS is not used.
