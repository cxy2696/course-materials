# Shared R helpers

`course_utils.R` is the small standard library used by the R course scripts.
Each R course folder has a `_setup.R` wrapper that finds the repository root and
sources this file.

## What it provides

| Function | Purpose |
| --- | --- |
| `read_data("file.csv")` | Find and read a course CSV in `csv files/`, `Data/`, `data/`, or `data/external/` |
| `read_external("sleep.txt")` | Read a cached public tab-separated dataset |
| `read_env_data("VAR", "default.csv")` | Read a dataset supplied through an environment variable |
| `require_packages(c("ggplot2"))` | Fail early with an actionable install command |
| `robust_summary(model)` | HC1 heteroskedasticity-robust coefficient table via `lmtest` + `sandwich` |

## Why it exists

The original scripts used `file.choose()` (not reproducible), read absolute or
remote paths, and called `summary(model, robust = TRUE)`. Base R's `summary.lm`
silently ignores the `robust` argument, so those calls did **not** produce robust
standard errors unless a course-local helper happened to be loaded. This module
makes the intent explicit:

```r
source("_setup.R")
cars <- read_data("93cars.csv")
model <- lm(HMPG ~ Type, data = cars)
robust_summary(model)          # HC1 coefficient table
```

## Adding a course

Create a one-file `_setup.R` in the course folder that resolves the repository
root and sources `R/course_utils.R`; copy the wrapper from an existing course
and adjust nothing else. `read_data()` starts its search from the folder that
contains `_setup.R`, so scripts can be run from their own directory.

See [`../docs/running-code.md`](../docs/running-code.md) for the full R setup.
