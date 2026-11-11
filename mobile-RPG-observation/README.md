# Mobile RPG Observation

An independent thesis project on the relationship between otaku culture and the
mobile-RPG market. The question: does the proliferation of otaku culture
significantly influence the popularity and adoption of RPG mobile games in the
modern age?

The same analysis is in
[`../ECON411/`](../ECON411/README.md) (the course version). This folder is the
standalone project with its own README, thesis, R scripts, data, and poster.

## Key findings

The study finds a nuanced relationship: otaku-culture indicators (anime/manga
conventions, sales, and accessibility) are associated with mobile-RPG market
activity, but the effect is not uniform across revenue and downloads. Other
factors — mobile penetration, GDP, and country/year effects — matter, and the
short unbalanced panel limits causal claims. The thesis argues that cultural
affinity and economic dynamics interact rather than one simply driving the
other.

## What is inside

| Path | Description |
| --- | --- |
| `Thesis (1).docx` | Full thesis |
| `Thesis.R` | Main regressions and stargazer tables |
| `rpgD.R` | Panel/fixed-effects models and diagnostics |
| `panel plot.R` | Scatterplot/correlation matrix helpers |
| `rpgObservation.CSV` | Country-year panel |
| `Poster pictures/` | Figures, model tables, variable matrix, and poster PDFs |
| `README.md` | This guide |

![Revenue and downloads](<Poster pictures/results.png>)

## Panel variables

`rpgR` (revenue), `rpgD` (downloads), `user` (active mobile users),
`con` (conventions), `amsale` (anime/manga sales), `amR` (anime accessibility),
`anime` (combined culture index), `gdp`, `gdpperson`, `mobile`, `country`,
`year`.

## Run it

```r
install.packages(c("plm", "stargazer", "ggplot2", "coefplot", "car",
                   "corrplot", "lmtest", "sandwich", "dplyr"))
```

```bash
cd mobile-RPG-observation
Rscript Thesis.R
Rscript rpgD.R
```

Both scripts source `_setup.R` and load `rpgObservation.CSV`. The panel script
previously referenced an undefined `pdata` object (it created `ndata`); that is
fixed in the archive.

## Notes

* This is an observational study with a short panel; it documents associations,
  not causal effects.
* The thesis and figures are original work; the underlying Statista/World Bank
  extracts have their own terms.
* The old README used GitHub asset URLs from a previous repository; the images
  now point at the local `Poster pictures/` files.
