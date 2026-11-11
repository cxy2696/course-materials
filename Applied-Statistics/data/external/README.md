# External datasets

I downloaded these five small datasets from `statsci.org` because the R scripts
used to read them over the network. They are cached here so the labs run offline
and the results don't change if the site does.

| File | Original URL | Rows | Used by |
| --- | --- | ---: | --- |
| `insulgas.txt` | http://www.statsci.org/data/general/insulgas.txt | 44 | `ANCOVA.R` |
| `mazdas.txt` | http://www.statsci.org/data/oz/mazdas.txt | 124 | `CAR PRICES.R` |
| `sleep.txt` | http://www.statsci.org/data/general/sleep.txt | 62 | `Correlated Predictors and Nested F-Tests.R`, `mammalMLR.R` |
| `punting.txt` | http://www.statsci.org/data/general/punting.txt | 13 | `MLR Lab Report I.R` |
| `hanford.txt` | http://www.statsci.org/data/general/hanford.txt | 9 | `SLR Lab Report.R` |

I downloaded them on 2026-11-12. The files are tab-separated with a header row; the R
helper `read_external()` reads them with `read.table(header = TRUE)`.

The datasets are hosted by [statsci.org](http://www.statsci.org/) for educational
use. I keep them here so the course scripts stay reproducible.
