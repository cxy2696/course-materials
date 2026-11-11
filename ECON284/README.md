# Econometrics (Fall 2023)

Applied econometrics in R: simple and multiple regression, robust inference,
dummy variables, interactions, log specifications, and panel/fixed-effects
intuitions. The folder includes the datasets, the R scripts, and the exams.

## What is inside

| Path | Description |
| --- | --- |
| `classCode.R` | Main lecture script: class size, wage gaps, beer taxes, functional forms |
| `earnheight.R` | Earnings vs. sex |
| `hw.R` | Homework 8: returns to education with logs and quadratics |
| `Ed.R` | Simple regression of education on distance (dataset not included) |
| `f23 284_384 SW CH11.R` | Stock & Watson chapter 11: HMDA loan denials (AER data) |
| `f23 Ch13 .R` | Stock & Watson chapter 13: STAR experiment (AER data) |
| `Data/` | `caschool`, `wage2`, `fatality`, `mlb1`, `earnheight`, `wageData`, homework CSVs, `cps08.xlsx` |
| `Appendix/` | Textbook appendix, exam practice, figures |
| `F23 Exam 1-key.pdf` | Exam 1 answer key |

## Data

| File | What it is |
| --- | --- |
| `Data/caschool.csv` | California school districts: test scores, class size, income |
| `Data/wage2.csv` | 1980 National Longitudinal Survey wage data |
| `Data/fatality.csv` | State-year traffic fatality panel (beer taxes, etc.) |
| `Data/mlb1.csv` | Major League Baseball salaries and performance |
| `Data/earnheight.CSV` | Earnings, height, sex, age |
| `Data/wageData.CSV` | Current Population Survey wage extract |
| `Data/hw5-1.CSV`, `hw5-5.CSV`, `hw7-6.CSV`, `hw 8-5.CSV` | Homework datasets |
| `Data/cps08.xlsx` | CPS 2008 extract |

`Ed.R` uses a “distance” dataset that was not distributed with the course. Set
`ECON284_DISTANCE_DATA` to your local copy or put `distance.csv` in `Data/`.

## Run it

```r
install.packages(c("AER", "mfx", "stargazer", "lmtest", "sandwich"))
```

```bash
cd ECON284
Rscript classCode.R
```

The scripts source `_setup.R`, which loads the shared helpers in
[`../R/course_utils.R`](../R/course_utils.R). `read_data()` finds files in
`Data/`; `read_external()` is available for cached public data.

## A note on robust standard errors

The course originally used `summary(model, robust = TRUE)`, which relies on a
custom helper. Base R's `summary()` silently ignores that argument, so the
archive replaces those calls with `robust_summary()` (HC1 via
`sandwich`/`lmtest`). Re-run a script to get robust tables; the original exam
keys and reports may show conventional standard errors.

## Notes

* The AER-based scripts (`HMDA`, `STAR`) download/load package data, so they do
  not need the `Data/` folder.
* The textbook PDF and exam keys are instructor material.
