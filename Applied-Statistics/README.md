# Applied Statistics (Fall 2022)

This was my first serious R course. I wrote ten lab reports on regression and
ANOVA, a multiple-regression project on building energy use, and a
development-finance analysis with a partner.

## What I kept

| Path | What it is |
| --- | --- |
| `Lab reports/` | Nine PDF reports: R basics, data cleaning, SLR, MLR I/II, ANOVA, two-way ANOVA, ANCOVA, car prices |
| `R code/` | 38 analysis scripts and the shared `_setup.R` |
| `csv files/` | 15 datasets I used in the labs (cars, houses, penguins, snow petrels, choir, chocolate, ice cores, …) |
| `data/external/` | Five public statsci.org datasets I cached so the scripts run offline |
| `Project_3/` | The building energy-efficiency project: script, report, slides, `Energy.csv` |
| `MIGA_Issued_Projects.csv` | World Bank/MIGA extract I used in `MIGA.R` |
| `Stat2RCompanion.pdf` | The course's R companion |

The labs started with simple regression and diagnostics, then moved through
multiple regression, transformations, ANOVA, two-way ANOVA, ANCOVA, effect
sizes, and model selection. The project was the first time I fit a model to a
real dataset with more than a handful of columns.

## Running the scripts

I installed the packages once:

```r
install.packages(c(
  "car", "ggplot2", "lattice", "lmtest", "sandwich", "Sleuth3",
  "palmerpenguins", "stargazer", "knitr", "kableExtra", "dplyr"
))
```

Then ran a script from `R code`:

```bash
cd "Applied-Statistics/R code"
Rscript "ANOVA Inference.R"
```

Each script starts with `source("_setup.R")`, which loads the helpers in
[`../R/course_utils.R`](../R/course_utils.R). `read_data()` searches `csv files/`,
`Data/`, `data/`, and `data/external/`; `require_packages()` gives an install
command instead of a load error.

I got tired of the file picker, so the scripts now use explicit filenames. That
also makes them safe to run from a terminal.

### Which script uses which data

| Script(s) | Dataset |
| --- | --- |
| `ANOVA Inference.R`, `ANOVAinference.R`, `introToANOVA.R` | `93cars.csv` |
| `ANOVA Lab Report.R` | `ForbesTop2000-2017.csv` |
| `MLR Lab Report II.R` | `kc_house_data.csv` |
| `Multiple Linear Regression*.R`, `Outliers and Influential Points Warm Up.R` | `snowPetrels.csv` |
| `Polar Lab Report.R` | `ice_core.csv`, `isotope_and_T.csv` |
| `Two-Way ANOVA Lab.R` | `babes2.csv` |
| `mms2way.R` | `mms.csv` |
| `choir2way.R`, `choir2way-incomplete.R` | `singerHeightsData.csv` |
| `MIGA.R` | `MIGA_Issued_Projects.csv` |
| `Project_3/Project_3.R` | `Project_3/Energy.csv` |
| `ANCOVA.R`, `CAR PRICES.R`, `MLR Lab Report I.R`, `SLR Lab Report.R`, `mammalMLR.R`, `Correlated Predictors…R` | cached `data/external/*.txt` |
| `Effect Sizes.R`, `Reexpression.R`, `effectSizes.R`, `reexpression-multipleComparison.R`, `ANOVA and Regression with Indicators.R` | **`roots.csv` — I never had it** |

The “roots” data (fine-root diameter by fertilizer treatment) was never
distributed with the course. If you have a copy, put it in `csv files/`; the
helper will tell you what's missing if you don't.

## Notes

- The reports are the ones I submitted. I later cleaned up the scripts and data
  paths, but the statistical methods are unchanged.
- The course used `summary(model, robust = TRUE)`, which base R silently
  ignores. I added `robust_summary()` (HC1) in `R/course_utils.R` for scripts
  that need robust standard errors. If a report looked different from what you'd
  get now, that's why.
- `Stat2RCompanion.pdf` is course material.
