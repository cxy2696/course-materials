# Econometrics (Fall 2023)

I took Econometrics in fall 2023. The course moved from simple regression to
multiple regression, dummy variables, interactions, log specifications, and a
first look at panel/fixed-effects ideas. I kept the R scripts, the data, and the
exams.

## What I kept

| Path | What it is |
| --- | --- |
| `classCode.R` | The main lecture script: class size, wage gaps, beer taxes, functional forms |
| `earnheight.R` | Earnings vs. sex |
| `hw.R` | Homework 8: returns to education with logs and quadratics |
| `Ed.R` | Education vs. distance (the dataset wasn't included) |
| `f23 284_384 SW CH11.R` | Stock & Watson chapter 11: HMDA loan denials, using AER data |
| `f23 Ch13 .R` | Stock & Watson chapter 13: the STAR experiment |
| `Data/` | `caschool`, `wage2`, `fatality`, `mlb1`, `earnheight`, `wageData`, homework CSVs, `cps08.xlsx` |
| `Appendix/` | Textbook appendix, exam practice, figures |
| `F23 Exam 1-key.pdf` | Exam 1 answer key |

## Data

| File | What it is |
| --- | --- |
| `Data/caschool.csv` | California school districts: test scores, class size, income |
| `Data/wage2.csv` | 1980 National Longitudinal Survey wage data |
| `Data/fatality.csv` | State-year traffic fatalities and beer taxes |
| `Data/mlb1.csv` | MLB salaries and performance |
| `Data/earnheight.CSV` | Earnings, height, sex, age |
| `Data/wageData.CSV` | Current Population Survey wage extract |
| `Data/hw5-1.CSV`, `hw5-5.CSV`, `hw7-6.CSV`, `hw 8-5.CSV` | Homework data |
| `Data/cps08.xlsx` | CPS 2008 extract |

`Ed.R` needs a “distance” dataset that never came with the course. Set
`ECON284_DISTANCE_DATA` to a local copy, or put `distance.csv` in `Data/`.

## Running it

```r
install.packages(c("AER", "mfx", "stargazer", "lmtest", "sandwich"))
```

```bash
cd ECON284
Rscript classCode.R
```

The scripts load `_setup.R`, which points at the shared helpers in
[`../R/course_utils.R`](../R/course_utils.R). `read_data()` finds files in
`Data/`.

## A note on robust standard errors

We used `summary(model, robust = TRUE)` in class. That relies on a course-local
helper; base R's `summary()` silently ignores the argument. I replaced those
calls with `robust_summary()` (HC1 via `sandwich`/`lmtest`). The exam keys and
reports I kept may show conventional standard errors. I re-run a script if I
need the robust tables.

## Notes

- The AER scripts (`HMDA`, `STAR`) load package data, so they don't need the
  `Data/` folder.
- The textbook PDF and exam keys are course material.
