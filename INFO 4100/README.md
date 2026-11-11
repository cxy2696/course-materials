# INFO 4100 · R setup

`info4100-setup.Rmd` is the R Markdown setup assignment I did for INFO 4100. It
was mostly a check that `tidyverse`, vectors, data frames, and basic plots work
on my machine.

```bash
cd "INFO 4100"
Rscript -e 'rmarkdown::render("info4100-setup.Rmd")'
```

It needs `rmarkdown`, `knitr`, and `tidyverse`. The output type is
`word_document`, so the default result is a `.docx`.

From the repo root, `make r-check` renders it to a temporary directory and
prints `R Markdown OK`.

The file is still a course template. Replace the name and Cornell ID in the YAML
header before reusing it.
