# Spring 2025

Eight courses from the Spring 2025 semester, kept in one term folder (the two STSCI courses share a row below). The lecture
notes and readings are PDFs/PPTX; the market-design assignments are the code
worth running.

## What is inside

| Folder | Course | Contents | Code |
| --- | --- | --- | --- |
| `5080/` | STSCI 3080 · probability and statistics | 17 handwritten lecture sets, DeGroot & Schervish textbook, a materials-knowledge-graph paper | — |
| `5905/` | INFO 5905 · professional career development | Cover letter, job-analysis worksheet | — |
| `5940/` | INFO 4940/5940 · copyright and information law | Five reflection sets with case readings, midterm and final | — |
| `6220/` | INFO 4220/6220 · networks II: market design | 19 lecture decks, problem sets and solutions, two assignments, final deliverable | R, Python |
| `6820/` | 6820 · knowledge graphs for materials discovery | Nine papers on materials KGs, catalysts, and self-driving labs; research proposal | — |
| `6940/` | INFO 6940 · history of AI | Weekly reading sets, two midterm files, final | — |
| `STSCI/5090/` | STSCI 5090 · statistical inference | Lecture notes by Marten Wegkamp, practice exam, recitation sheets | — |
| `STSCI/5740/` | STSCI 5740 · statistical learning | *An Introduction to Statistical Learning* (ISLR2) | — |

### A note on `5080/`

The first lecture is headed **“STSCI 3080 — Lecture 1 (Chapter 1 in DeGroot and
Schervish)”**, while the folder is named `5080`. The folder name has been kept
to preserve existing links; the course content is the STSCI 3080 probability
sequence.

## Market design assignments (`6220/Assignment/`)

* `INFO6220-A1.R` — random serial dictatorship (RSD) for four students and four
  objects, followed by deferred acceptance (DA) versus top trading cycles (TTC)
  for a 60-student school-choice problem.
* `INFO6220-A2.R` — single versus multiple tie-breaking with the
  `matchingMarkets` package (`hri`).
* `INFO6220-A2-custom-DA.R` — the same question with a hand-written deferred
  acceptance implementation.
* `A2.ipynb` — a Python companion notebook.
* `_setup.R` — checks that `matchingMarkets` is installed.

Run from the assignment folder:

```bash
cd "2025Spring/6220/Assignment"
Rscript INFO6220-A1.R
Rscript INFO6220-A2.R
```

The scripts set a seed, so results are reproducible. They originally called
`install.packages()` at runtime and shadowed the loop variable `i`; both are
fixed. The assignment PDFs are in the same folder; the names of the submitted
files may differ from the practice versions.

## Notes

* `5940/` reflections are tied to specific case PDFs (Feist, Mannion, Star,
  Oracle, Campbell, Warhol, …). They are useful as a reading map.
* `6940/` has two copies of the midterm (`INFO6940_Midterm.pdf` and
  `INFO6940_Midterm (1).pdf`); they are retained because they are not
  byte-identical.
* The readings and textbooks are course material.
