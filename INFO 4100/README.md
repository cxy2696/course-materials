# INFO 4100 · R setup

`info4100-setup.Rmd` is the R Markdown setup assignment for INFO 4100. It covers
`tidyverse`, vectors and data frames, and basic plots.

```bash
cd "INFO 4100"
Rscript -e 'rmarkdown::render("info4100-setup.Rmd")'
```

Requires `rmarkdown`, `knitr`, and `tidyverse`. The output type is
`word_document`, so the default result is a `.docx`.

From the repository root, `make r-check` renders to a temporary directory and
prints `R Markdown OK`.

The file is a course template; replace the name and Cornell ID in the YAML header
before submitting.
