# External datasets

These five small datasets were originally read directly from `statsci.org` by
the R scripts. They are cached here so the labs run offline and the analysis is
stable if the site changes.

| File | Original URL | Rows | Used by |
| --- | --- | ---: | --- |
| `insulgas.txt` | http://www.statsci.org/data/general/insulgas.txt | 44 | `ANCOVA.R` |
| `mazdas.txt` | http://www.statsci.org/data/oz/mazdas.txt | 124 | `CAR PRICES.R` |
| `sleep.txt` | http://www.statsci.org/data/general/sleep.txt | 62 | `Correlated Predictors and Nested F-Tests.R`, `mammalMLR.R` |
| `punting.txt` | http://www.statsci.org/data/general/punting.txt | 13 | `MLR Lab Report I.R` |
| `hanford.txt` | http://www.statsci.org/data/general/hanford.txt | 9 | `SLR Lab Report.R` |

Downloaded on 2026-11-12. The files are tab-separated with a header row; the R
helper `read_external()` reads them with `read.table(header = TRUE)`.

The datasets are hosted by [statsci.org](http://www.statsci.org/) for
educational use. They are reproduced here only to make the course scripts
reproducible; see the site and the original sources for citation and licensing
details.
