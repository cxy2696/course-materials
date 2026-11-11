# Applied Statistics (Fall 2022)

A semester of applied regression and ANOVA in R: ten lab reports, a
multiple-regression project on building energy use, a development-finance
analysis, and the datasets that drive them.

## What is inside

| Path | Description |
| --- | --- |
| `Lab reports/` | Nine lab reports (PDF): R basics, data cleaning, SLR, MLR I/II, ANOVA, two-way ANOVA, ANCOVA, car prices |
| `R code/` | 38 analysis scripts plus a shared `_setup.R` wrapper |
| `csv files/` | 15 course datasets (cars, houses, penguins, snow petrels, choir, chocolate, ice cores, …) |
| `data/external/` | Five public statsci.org datasets cached for offline use |
| `Project_3/` | Building energy-efficiency regression: `Project_3.R`, report, slide deck, `Energy.csv` |
| `MIGA_Issued_Projects.csv` | World Bank/MIGA development-finance extract used by `MIGA.R` |
| `Stat2RCompanion.pdf` | The course's R companion to *Stat2* |

### What the labs cover

* simple and multiple linear regression, diagnostics, transformations;
* ANOVA, two-way ANOVA, ANCOVA, effect sizes, and multiple comparisons;
* model selection (SAT data) and correlated predictors;
* a full project predicting heating load from building characteristics.

## Running the scripts

Install the packages once:

```r
install.packages(c(
  "car", "ggplot2", "lattice", "lmtest", "sandwich", "Sleuth3",
  "palmerpenguins", "stargazer", "knitr", "kableExtra", "dplyr"
))
```

Then run a script from the `R code` folder:

```bash
cd "Applied-Statistics/R code"
Rscript "ANOVA Inference.R"
```

Every script starts with `source("_setup.R")`, which loads the shared helpers in
[`../R/course_utils.R`](../R/course_utils.R):

* `read_data("93cars.csv")` searches `csv files/`, `Data/`, `data/`, and
  `data/external/` relative to the course;
* `read_external("sleep.txt")` reads a cached public dataset;
* `require_packages()` gives an install command instead of a cryptic load error.

The original scripts opened a file picker with `file.choose()`. They now use
explicit filenames, so they are reproducible and safe to run non-interactively.

### Which script uses which dataset

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
| `Effect Sizes.R`, `Reexpression.R`, `effectSizes.R`, `reexpression-multipleComparison.R`, `ANOVA and Regression with Indicators.R` | **`roots.csv` — not included** |

The “roots” dataset (fine-root diameter by fertilizer treatment) was not
distributed with the course materials. Put a copy in `csv files/` or point the
script at your own file; the helper will explain what is missing.

## Notes

* The reports are the original submissions. Some scripts were later cleaned up
  (explicit paths, package checks); the statistical methods are unchanged.
* The `summary(model, robust = TRUE)` idiom used in the course relied on a
  course-local helper. Base R silently ignores that argument, so this archive
  provides `robust_summary()` (HC1 via `sandwich`/`lmtest`) in
  `R/course_utils.R` for scripts that need robust standard errors.
* `Stat2RCompanion.pdf` and the textbooks are third-party material; see
  [`../docs/third-party-materials.md`](../docs/third-party-materials.md).
