# Mobile RPG Observation

This is my thesis project on otaku culture and the mobile-RPG market. I asked
whether the growth of otaku culture helps explain the popularity and revenue of
RPG mobile games, and I built a country-year panel to look at it.

The same analysis is in [`../ECON411/`](../ECON411/README.md), which is the
course version. This folder is the standalone project I published separately.

## What I found

The relationship is not a simple “more anime = more revenue” story. Otaku-culture
indicators — conventions, anime/manga sales, and anime availability — are
associated with mobile-RPG market activity, but the effect is not uniform across
revenue and downloads. Mobile penetration, GDP, and country/year effects also
matter, and the panel is short and unbalanced, so I don't read it as causal.

## What's here

| Path | What it is |
| --- | --- |
| `Thesis (1).docx` | The full thesis |
| `Thesis.R` | Main regressions and stargazer tables |
| `rpgD.R` | Panel/fixed-effects models and diagnostics |
| `panel plot.R` | Scatterplot/correlation helpers |
| `rpgObservation.CSV` | The country-year panel |
| `Poster pictures/` | Figures, model tables, variable matrix, and poster PDFs |

The panel variables are `rpgR` (revenue), `rpgD` (downloads), `user` (active
mobile users), `con` (conventions), `amsale` (anime/manga sales), `amR` (anime
accessibility), `anime` (combined culture index), `gdp`, `gdpperson`, `mobile`,
`country`, and `year`.

## Running it

```r
install.packages(c("plm", "stargazer", "ggplot2", "coefplot", "car",
                   "corrplot", "lmtest", "sandwich", "dplyr"))
```

```bash
cd mobile-RPG-observation
Rscript Thesis.R
Rscript rpgD.R
```

Both scripts load `_setup.R` and read `rpgObservation.CSV`. `rpgD.R` had a bug
where it created `ndata` but used an undefined `pdata`; I fixed it.

## Notes

- This is an observational study with a short panel. It describes associations,
  not causal effects.
- The thesis and figures are mine. The underlying Statista and World Bank
  extracts have their own terms.
- The old README used GitHub asset URLs from a previous repository; the images
  now point at the local `Poster pictures/` files.
