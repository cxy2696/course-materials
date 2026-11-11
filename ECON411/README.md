# Econometrics Research Thesis (Fall 2023)

A panel-data study of the mobile-RPG market: do otaku-culture indicators (anime
conventions, anime/manga sales, anime availability) help explain RPG revenue
and downloads after controlling for GDP, mobile penetration, and country/year
fixed effects?

The same project is mirrored in
[`../mobile-RPG-observation/`](../mobile-RPG-observation/), which was published
as a standalone repository. This folder is the course version, including the
data-collection notes and the poster.

## What is inside

| Path | Description |
| --- | --- |
| `Thesis.R` | Main regressions, scatterplot matrices, stargazer tables |
| `rpgD.R` | Panel/fixed-effects specifications with `plm`, diagnostics, coefficient plots |
| `panel plot.R` | Correlation/scatterplot matrix helpers |
| `f23 Econometrics Review.R` | Course review scripts (class size, MLB salaries) |
| `rpgObservation.CSV` | Country-year panel used by the thesis |
| `DataCollection/` | Raw Statista, World Bank, anime-industry, and mobile-market extracts |
| `Poster pictures/` | Figures, model tables, and `data.py` (AnimeCons scraper template) |
| `MyTable1.htm`, `MyTable2.htm` | Stargazer HTML regression tables |
| `Continet&Country.png` | Map/figure used in the poster |

### Panel variables

`rpgR` (RPG revenue), `rpgD` (downloads), `user` (active mobile users),
`con` (anime/manga conventions), `amsale` (anime/manga sales), `amR` (anime
availability), `anime` (combined culture index), `gdp`, `gdpperson`, `mobile`,
`country`, `year`.

## Run it

```r
install.packages(c("plm", "stargazer", "ggplot2", "coefplot", "car",
                   "corrplot", "lmtest", "sandwich", "dplyr", "knitr",
                   "kableExtra", "scatterplot3d"))
```

```bash
cd ECON411
Rscript Thesis.R
Rscript rpgD.R
```

The scripts read `rpgObservation.CSV` through `_setup.R`. `rpgD.R` builds a
`pdata.frame` and estimates country/year fixed-effect models; it previously
created `ndata` but referenced an undefined `pdata`, which is fixed.

## Notes

* The panel is short and unbalanced; the thesis is an exploratory observational
  study, not a causal estimate.
* `DataCollection/` preserves original filenames (including Statista statistic
  IDs). Check the source terms before reusing the data commercially.
* `Poster pictures/data.py` is a template for parsing a saved AnimeCons events
  page; the live site blocks scripted requests with Cloudflare.
* The thesis text is in `../mobile-RPG-observation/Thesis (1).docx`; the poster
  figures here match it.
* Third-party data and figures: see
  [`../docs/third-party-materials.md`](../docs/third-party-materials.md).
