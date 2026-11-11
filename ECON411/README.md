# Econometrics Research Thesis (Fall 2023)

This was my econometrics thesis: does otaku culture help explain mobile-RPG
revenue and downloads, after controlling for GDP, mobile penetration, and
country/year effects? I built a country-year panel from public data and ran
fixed-effects specifications.

I also keep the standalone copy in
[`../mobile-RPG-observation/`](../mobile-RPG-observation/README.md). This folder
is the course version, with the data-collection notes and poster.

## What I kept

| Path | What it is |
| --- | --- |
| `Thesis.R` | Main regressions, scatterplot matrices, stargazer tables |
| `rpgD.R` | Panel/fixed-effects specifications with `plm`, diagnostics, coefficient plots |
| `panel plot.R` | Correlation/scatterplot helpers |
| `f23 Econometrics Review.R` | Course review scripts (class size, MLB salaries) |
| `rpgObservation.CSV` | The country-year panel |
| `DataCollection/` | Raw Statista, World Bank, anime-industry, and mobile-market extracts |
| `Poster pictures/` | Figures, model tables, and `data.py` |
| `MyTable1.htm`, `MyTable2.htm` | Stargazer HTML tables |
| `Continet&Country.png` | Map used in the poster |

The panel variables are `rpgR` (revenue), `rpgD` (downloads), `user` (active
mobile users), `con` (conventions), `amsale` (anime/manga sales), `amR` (anime
availability), `anime` (combined culture index), `gdp`, `gdpperson`, `mobile`,
`country`, and `year`.

## Running it

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

Both read `rpgObservation.CSV` through `_setup.R`. `rpgD.R` builds a
`pdata.frame` and estimates the country/year fixed-effect models. I fixed a bug
where it created `ndata` but then used an undefined `pdata`.

## Notes

- The panel is short and unbalanced. This is an exploratory observational
  study, not a causal estimate.
- `DataCollection/` keeps the original file names, including the Statista
  statistic IDs. Check the source terms before commercial reuse.
- `Poster pictures/data.py` parses a saved AnimeCons events page. The live site
  blocks scripted requests with Cloudflare.
- The thesis text is in `../mobile-RPG-observation/Thesis (1).docx`; the poster
  figures here match it.
