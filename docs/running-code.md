# Running the code

The archive mixes Python, R, Julia/Pluto, SQL, Tableau, and LaTeX. You do not
need every tool to browse it — each course README lists what that course uses.
This page covers the common setups and the commands that were verified during
the November 2026 cleanup.

## Prerequisites

| Tool | Version used for verification | Needed for |
| --- | --- | --- |
| Python | 3.11+ (3.13 tested) | notebooks, scripts, `tools/check_repo.py` |
| JDK | 17 | `CSCI 161` Java labs |
| C++ | C++17 | `C++` example |
| R | 4.4 | `Applied-Statistics`, `ECON284`, `ECON411`, `2025Spring/6220` |
| Julia | 1.10+ (1.11 tested) | `Matrix Computations` |
| PostgreSQL | 15 client (server optional) | `CS_5320` |
| Tableau Desktop/Public | recent release | `BI Systems` workbooks |
| LaTeX | TeX Live / MacTeX | `Category Theory` handouts, `INFO_6850` notes |

## Python

Create one environment at the repository root:

```bash
python3 -m venv .venv
source .venv/bin/activate          # Windows: .venv\Scripts\activate
pip install --upgrade pip
pip install -r requirements.txt
```

For the "AI in Organizations" notebooks, also install the optional stack:

```bash
pip install -r requirements-ai.txt
```

Launch notebooks with:

```bash
jupyter lab
```

Most notebooks expect to be launched from **their own folder** because they read
files such as `authors.csv`, `ps1data.txt`, or `data/faces/`. The
numerical-analysis notebooks resolve `data/` by walking up from the current
directory, so launching Jupyter in `Numerical-Analysis-Lab/Lab` or in the
course root both work.

### Coauthorship analysis

```bash
cd InfoNetworks/pythonCoauthorship
python code.py --output-dir outputs
```

This writes `hw1solution.txt` and `plot1.pdf`–`plot4.pdf` to `outputs/`. The
custom BFS variant is run the same way:

```bash
cd InfoNetworks/pythonCoauthorship_customBFStree
python custom_bfs.py --output-dir outputs
```

Both use the same parsing and graph code; the second selects the explicit
FIFO-queue implementation for Problems 3 and 4. They share
`pythonCoauthorship/ps1data.txt`.

### HNL voter model

```bash
cd InfoNetworks/hnl_voter_model
python -m hnl_voter_model --nodes 100 --edges 20 --steps 100 --seed 42
python -m hnl_voter_model   --dataset ../pythonCS6850_Project/PythonHybrid/sentimentdataset.csv --steps 50
```

### Machine-learning notebooks

Install the optional stack, then open the notebook from `Machine Learning/`:

```bash
python -m pip install -r "Machine Learning/requirements-ml.txt"
jupyter lab "Machine Learning/knn/knn.ipynb"
```

### MATH-Modeling notebooks

The full MATH 310 archive has its own requirements file and 74 notebooks:

```bash
cd MATH-Modeling
python3 -m venv .venv && source .venv/bin/activate
pip install -r requirements.txt
jupyter lab
```

Start with `notebooks/README.md`, which lists the ten topic folders in learning
order. The smaller lab subset in `../Numerical-Analysis-Lab/` uses the root
`requirements.txt`. The folder’s own checker validates its notebook/link/data
paths:

```bash
python "MATH-Modeling/scripts/check_repo.py"
```

### Exercise notebook

```bash
cd exercises
cp .env.example .env
# edit .env and add GEMINI_API_KEY / SEMANTIC_SCHOLAR_API_KEY
jupyter lab questions.ipynb
```

Task 1 needs only the local CSV/Parquet files. Task 2 requires a Gemini key.
Task 3 works without a key at lower rate limits.

## Java

```bash
./CSCI\ 161/build.sh
./CSCI\ 161/test.sh
./CSCI\ 161/run.sh
```

The graphics programs save a PNG to `CSCI 161/out/` when no display is available.
`make java-test` runs the self-tests from the repository root.

## C++

```bash
make -C C++/hello-world
./C++/hello-world/build/hello-world
```

`make cpp-test` builds and runs it.

## R

Install the packages used by the scripts you want to run. A superset:

```r
install.packages(c(
  "AER", "car", "coefplot", "dplyr", "ggplot2", "kableExtra", "knitr",
  "lattice", "lmtest", "matchingMarkets", "mfx", "palmerpenguins", "plm",
  "sandwich", "scatterplot3d", "Sleuth3", "stargazer"
))
```

Run a script from its own folder so the shared `_setup.R` is found:

```bash
cd "Applied-Statistics/R code"
Rscript "ANOVA Inference.R"
```

`_setup.R` (in each R course folder) loads `R/course_utils.R`, which provides:

* `read_data("snowPetrels.csv")` — search the course's data folders;
* `read_external("sleep.txt")` — read a cached public dataset;
* `require_packages()` — fail early with an install command;
* `robust_summary(model)` — HC1 heteroskedasticity-robust coefficient table.

This replaces the original course-local `summary(model, robust = TRUE)` calls,
which base R silently ignores. Reports generated before the cleanup therefore
may show conventional standard errors; re-run the script for robust ones.

**Data lookup.** `read_data()` searches the script folder and its parents for
`csv files/`, `Data/`, `data/`, `data/external/`, and `Project_3/`. This is why
running from the course folder is important.

**Missing datasets.** Two datasets were not distributed with the course and are
not invented here:

| Dataset | Used by | How to supply it |
| --- | --- | --- |
| `roots.csv` (fine-root diameter/treatment) | `Effect Sizes.R`, `Reexpression.R`, `ANOVA and Regression with Indicators.R`, `effectSizes.R`, `reexpression-multipleComparison.R` | Put it in `Applied-Statistics/csv files/` |
| `distance.csv` (education vs distance) | `ECON284/Ed.R` | Set `ECON284_DISTANCE_DATA=/path/to/distance.csv` |

The “choir” scripts use `singerHeightsData.csv`, which is included.

The five public statsci.org datasets (`insulgas`, `mazdas`, `sleep`, `punting`,
`hanford`) are cached in `Applied-Statistics/data/external/` so the scripts run
offline.

## Julia and Pluto

The `Matrix Computations` folder now has a `Project.toml`. Instantiate it once:

```bash
julia --project="Matrix Computations" -e 'using Pkg; Pkg.instantiate()'
```

Open a Pluto notebook (the `.jl` files under `hw/` are Pluto notebooks):

```bash
julia --project="Matrix Computations" -e 'using Pluto; Pluto.run()'
```

Then open, for example, `Matrix Computations/hw/hw1.jl` in the Pluto window.
The plain PDFs next to each notebook are the submitted write-ups.

The Bayesian-optimization tutorial has its own environment:

```bash
julia --project="Matrix Computations/bo-tutorial" -e 'using Pkg; Pkg.instantiate()'
julia --project="Matrix Computations/bo-tutorial" "Matrix Computations/bo-tutorial/src/bo-tutorial.jl"
```

Alternatively, open `vanilla_bo.ipynb` in Jupyter with a Julia kernel.

## SQL (PostgreSQL)

The `CS_5320` lab loads a CSV with psql's client-side `\copy`, so no server file
permissions are needed:

```bash
cd CS_5320
createdb bars
psql -d bars -f SQLfolder/bars.pgsql
```

Run it from the `CS_5320` folder: the script's relative path is
`csv/chocolate_bars.csv`. The file creates the table and prints the answer to
ten labelled queries (`\echo 'Q1 …'`).

## Tableau

The `BI Systems` workbooks (`*.twb`) are XML and can be opened with Tableau
Desktop or Tableau Public. They reference local data sources from the original
project; reconnect or replace the data source if Tableau cannot find it. The
PDFs in `BI Systems/done/` show the submitted dashboards.

## LaTeX

The category-theory diagrams use the included `quiver.sty`:

```bash
cd "Category Theory (Programming Languages)/hw"
python -m pip install Pygments
pdflatex -shell-escape quiver-doc.tex
pdflatex -shell-escape quiver-doc.tex
```


## Per-course commands

| Course | Command |
| --- | --- |
| Applied statistics | `cd "Applied-Statistics/R code" && Rscript "Polar Lab Report.R"` |
| Econometrics | `cd ECON284 && Rscript classCode.R` |
| Thesis panel analysis | `cd ECON411 && Rscript rpgD.R` |
| Market design | `cd "2025Spring/6220/Assignment" && Rscript INFO6220-A1.R` |
| Coauthorship | `cd InfoNetworks/pythonCoauthorship && python code.py` |
| Exercise notebook | `cd exercises && jupyter lab questions.ipynb` |
| Full numerical-analysis course | `cd MATH-Modeling && pip install -r requirements.txt && jupyter lab` |
| Numerical labs | `cd Numerical-Analysis-Lab/Lab && jupyter lab` |
| Matrix computations | `julia --project="Matrix Computations" -e 'using Pluto; Pluto.run()'` |
| Database lab | `cd CS_5320 && psql -d bars -f SQLfolder/bars.pgsql` |
| Repository check | `make check` |

## Verification and troubleshooting

`make check` validates notebook JSON, Python/R/Julia syntax, tracked junk files,
relative Markdown links, and accidentally committed secrets:

```bash
make check
make check-fast      # skip R/Julia parsers
python3 tools/check_repo.py
```

Common issues:

* **`Could not find 'roots.csv'`** — that dataset is not in the archive; see the
  table above.
* **`Missing R package(s)`** — run the printed `install.packages(...)` command.
* **Pluto notebook does not run** — instantiate the Julia project first; Pluto
  packages are listed in `Matrix Computations/Project.toml`.
* **`psql: error: connection … failed`** — start PostgreSQL or point
  `PGHOST`/`PGPORT` at a running server.
* **Notebook cannot find `data/`** — launch it from inside
  `Numerical-Analysis-Lab` (the helper walks up to the folder containing
  `data/`).
* **Tableau cannot find the data** — edit the connection in Tableau; the
  original project used local files.
