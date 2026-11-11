# Shared R helpers

I got tired of editing the same data paths in every R script, so I put the
common bits in `course_utils.R`. Each R course folder has a `_setup.R` that
finds the repo root and sources it.

## What's in it

| Function | What it does |
| --- | --- |
| `read_data("file.csv")` | Finds and reads a course CSV in `csv files/`, `Data/`, `data/`, or `data/external/` |
| `read_external("sleep.txt")` | Reads a cached public tab-separated dataset |
| `read_env_data("VAR", "default.csv")` | Reads a dataset I supply through an environment variable |
| `require_packages(c("ggplot2"))` | Stops early with an install command |
| `robust_summary(model)` | HC1 robust coefficient table via `lmtest` and `sandwich` |

## Why I added it

The original scripts used `file.choose()` (not reproducible), absolute or remote
paths, and `summary(model, robust = TRUE)`. Base R's `summary.lm` silently
ignores the `robust` argument, so those calls were not producing robust standard
errors unless a course-local helper happened to be loaded. I wanted the intent
to be explicit:

```r
source("_setup.R")
cars <- read_data("93cars.csv")
model <- lm(HMPG ~ Type, data = cars)
robust_summary(model)
```

## Adding a course

Copy the small `_setup.R` from an existing course into the new folder. It
resolves the repo root and sources this file; `read_data()` starts its search
from the folder that contains `_setup.R`, so scripts can run from their own
directory.

See [`../docs/running-code.md`](../docs/running-code.md) for the R setup.
