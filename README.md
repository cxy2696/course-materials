# Course Materials

[![Quality checks](https://github.com/cxy2696/course-materials/actions/workflows/quality.yml/badge.svg)](https://github.com/cxy2696/course-materials/actions/workflows/quality.yml)

A curated archive of university coursework in **information science, computer
science, statistics, economics, and business** (2022–2025). It collects lecture
notes, lab reports, problem sets, presentations, and — most importantly — the
code and data behind the analyses.

The archive is meant to be readable and reusable: every course has a guide, the
code avoids hard-coded local paths, public datasets are cached where possible,
and a single command checks the repository's hygiene.

```bash
git clone https://github.com/cxy2696/course-materials.git
cd course-materials
make check          # notebooks, links, secrets, Python/R/Julia syntax
```

## What is inside

| Folder | Course | Term | Highlights | Code |
| --- | --- | --- | --- | --- |
| [`2025Spring/`](<2025Spring/README.md>) | Eight-course Spring 2025 archive: STSCI 3080, INFO 5905, INFO 4940/5940, INFO 4220/6220, 6820, INFO 6940, STSCI 5090/5740 | Spring 2025 | probability notes, copyright case reflections, market-design simulations | R, Python, LaTeX |
| [`AI in Organizations/`](<AI in Organizations/README.md>) | INFO 1170/5170 · AI in Organizations | Fall 2025 | LLM prompting, RAG chatbot, final project | Python |
| [`Applied-Statistics/`](<Applied-Statistics/README.md>) | Applied statistics | Fall 2022 | nine lab reports, 38 R scripts, energy-efficiency project | R |
| [`BI Systems/`](<BI Systems/README.md>) | INFO 4555/5556 · Business Intelligence Systems | Fall 2025 | data-warehouse project, Tableau, WhereScape, SQL | SQL, Tableau |
| [`BUS435/`](<BUS435/README.md>) | International Financial Management | Fall 2023 | AIFS currency-hedging case, FX notes | Python |
| [`Basins-of-Attraction/`](<Basins-of-Attraction/README.md>) | MATH 310 · Lab 1 | Spring 2024 | Newton's-method fractals | Python |
| [`CS_5320/`](<CS_5320/README.md>) | Database Systems | Fall 2024 | storage, indexes, query optimization, SQL lab | SQL |
| [`Category Theory (Programming Languages)/`](<Category Theory (Programming Languages)/README.md>) | Programming-languages seminar | Fall 2025 | eight problem sets, papers, commutative diagrams | LaTeX |
| [`ECON284/`](<ECON284/README.md>) | Econometrics | Fall 2023 | R labs, exams, AER replications | R |
| [`ECON411/`](<ECON411/README.md>) | Econometrics research thesis | Fall 2023 | mobile-RPG panel study, poster, data collection | R, Python |
| [`INFO_5355/`](<INFO_5355/README.md>) | INFO 5355 · Human-Computer Interaction Design | Fall 2024 | UX assignments, interview study | — |
| [`INFO_6850/`](<INFO_6850/README.md>) | INFO 6850 · Information Networks | Fall 2024 | problem sets, spectral/random-walk notes, reaction paper | Python |
| [`InfoNetworks/`](<InfoNetworks/README.md>) | CS 6850 project | Fall 2024 | coauthorship graph, hybrid-contagion simulations | Python |
| [`Matrix Computations/`](<Matrix Computations/README.md>) | CS 6210 · Matrix Computations | Fall 2025 | ten Pluto problem sets, Bayesian-optimization tutorial | Julia |
| [`Numerical-Analysis-Lab/`](<Numerical-Analysis-Lab/README.md>) | MATH 310 · Numerical Analysis Lab | 2024 | four labs, two projects, PCA face recognition | Python |
| [`exercises/`](<exercises/README.md>) | Take-home data exercise | 2025 | messy publication data, Gemini and Semantic Scholar APIs | Python |
| [`mobile-RPG-observation/`](<mobile-RPG-observation/README.md>) | Independent thesis | 2024 | otaku culture and the mobile-RPG market | R |

Shared infrastructure:

* [`docs/`](docs/README.md) — catalog, running guide, conventions, privacy, licensing, security.
* [`R/`](R/README.md) — shared R helpers used by the course scripts.
* [`tools/check_repo.py`](tools/check_repo.py) — the hygiene and syntax checker.

## Start here

**Looking for a specific course?** Use the table above, then open that folder's
`README.md`. The detailed semester-by-semester catalog is in
[`docs/catalog.md`](docs/catalog.md).

**Want to run something?**

| I want to… | Go to |
| --- | --- |
| analyse a coauthorship network | [`InfoNetworks/`](<InfoNetworks/README.md>) |
| reproduce a statistics lab | [`Applied-Statistics/README.md`](<Applied-Statistics/README.md>) |
| open the Julia homework | [`Matrix Computations/README.md`](<Matrix Computations/README.md>) |
| run the SQL exercises | [`CS_5320/README.md`](<CS_5320/README.md>) |
| see the numerical-methods labs | [`Numerical-Analysis-Lab/README.md`](<Numerical-Analysis-Lab/README.md>) |
| run the RAG/LLM assignment | [`AI in Organizations/README.md`](<AI in Organizations/README.md>) |

Full setup instructions for Python, R, Julia, PostgreSQL, Tableau, and LaTeX are
in [`docs/running-code.md`](docs/running-code.md).

## Highlights

* **Numerical analysis** — Newton basins of attraction, climate calculus, LU
  factorization, and PCA-based face recognition, with reports and notebooks.
* **Network science** — a 32k-node coauthorship analysis (degree distribution,
  components, BFS levels) and hybrid-contagion simulations.
* **Matrix computations** — Julia/Pluto problem sets plus a self-contained
  Bayesian-optimization tutorial adapted from Peter Frazier's paper.
* **Market design** — random serial dictatorship, deferred acceptance, and
  top-trading-cycles simulations for school choice.
* **Business intelligence** — a full data-warehouse project with dimensional
  models, ETL, Tableau dashboards, and a WhereScape case.
* **Applied AI** — retrieval-augmented generation (RAG) over legal/health
  documents and LLM API exercises.

## What this cleanup changed

This repository was refreshed in November 2026. The main changes:

* **Documentation** — a real landing page, 17 course-guide READMEs, and a
  `docs/` set covering the catalog, running code, conventions, privacy, and
  third-party material.
* **Reproducibility** — `file.choose()` prompts replaced by explicit data
  paths; public statistics datasets cached under
  `Applied-Statistics/data/external/`; Julia `Project.toml` files; Python
  `requirements.txt`; SQL DDL with a relative `\copy`.
* **Correctness** — fixed a coauthorship parser that mixed bibliography
  metadata into author names, an undefined `pdata` object in the panel-data
  script, an invalid R default argument, and silent `summary(..., robust=TRUE)`
  calls (now `robust_summary()` with HC1 standard errors).
* **Notebook portability** — removed Windows absolute paths and remote image
  URLs from the numerical-analysis labs; data now lives in one `data/` folder.
* **Hygiene** — removed 16 `.DS_Store` files, Office lock files, notebook
  checkpoints, redundant archives, and exact duplicates; added `.gitignore`,
  `.gitattributes`, and CI checks.
* **Security** — removed a committed Google API key from the exercise notebook
  and documented the incident. **The key is still in git history; revoke it.**
  See [`docs/security.md`](docs/security.md).

Most original notebook outputs are intentionally retained: they document what
the submissions produced. The exercise notebook's outputs were cleared when its
leaked key was removed. Where the cleanup changed an analysis (for example the
coauthorship parser or robust standard errors), the outputs were regenerated or
the difference is noted in the course README.

## Data, privacy, and licensing

* **Code and original writing** are MIT-licensed (see [`LICENSE`](LICENSE)).
* **Third-party readings, textbooks, slides, case studies, and images** keep
  their original copyright and are included for personal study only. See
  [`docs/third-party-materials.md`](docs/third-party-materials.md).
* **Human-subjects material**: `INFO_5355/Interview Recording (Anny)-…zip`
  contains interview transcripts and notes. Review
  [`docs/data-and-privacy.md`](docs/data-and-privacy.md) before redistributing
  or reusing it.
* Some datasets referenced by the R labs were not distributed with the course
  and are not in the repository (for example the "roots" data). The course
  READMEs explain how to supply them.

## Repository conventions

* Course folders keep their original names and semester structure so old links
  continue to work.
* Each course folder has a `README.md` describing what is inside and how to run
  it.
* Data lives in a `data/`, `csv files/`, or `Data/` folder next to the code;
  generated plots go to an ignored `outputs/` folder.
* New code should be runnable from its own folder and should not depend on
  absolute paths or interactive file pickers.
* Run `make check` before committing. See
  [`docs/repository-conventions.md`](docs/repository-conventions.md) and
  [`CONTRIBUTING.md`](CONTRIBUTING.md).

## Citation

If you reference this archive, use the metadata in [`CITATION.cff`](CITATION.cff):

> Cui, Xinyi (Anny). *Course Materials: Information Science, Computer Science,
> and Economics Coursework.* 2026. https://github.com/cxy2696/course-materials

## Maintenance

The archive is maintained by [@cxy2696](https://github.com/cxy2696). Issues and
corrections are welcome; please read [`CONTRIBUTING.md`](CONTRIBUTING.md) first.
