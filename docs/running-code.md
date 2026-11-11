# Running the code

I use a mix of Python, R, Julia/Pluto, SQL, Java, C++, Tableau, and LaTeX in
these folders. You don't need all of it to browse the repo; each course README
says what that course uses.

Below is the setup I used for the last pass, plus the commands I actually ran.

## Prerequisites

| Tool | Version I used | Needed for |
| --- | --- | --- |
| Python | 3.11+ (3.13 tested) | notebooks, scripts, `tools/check_repo.py` |
| JDK | 17 | `CSCI 161` Java labs |
| C++ | C++17 | `C++` example |
| R | 4.4 | `Applied-Statistics`, `ECON284`, `ECON411`, `2025Spring/6220` |
| Julia | 1.10+ (1.11 tested) | `Matrix Computations` |
| PostgreSQL | 15 client (server optional) | `CS_5320` |
| Tableau Desktop/Public | recent release | `BI Systems` workbooks |
| LaTeX | TeX Live / MacTeX | `Category Theory` notes, `INFO_6850` |

## Python

I keep one virtual environment at the repository root:

```bash
python3 -m venv .venv
source .venv/bin/activate          # Windows: .venv\Scripts\activate
pip install --upgrade pip
pip install -r requirements.txt
```

For the "AI in Organizations" notebooks, I also install the optional stack:

```bash
pip install -r requirements-ai.txt
```

Then:

```bash
jupyter lab
```

Most notebooks expect to be launched from their own folder because they read
files like `authors.csv`, `ps1data.txt`, or `data/faces/`. The numerical-analysis
notebooks walk up to find `data/`, so starting Jupyter in
`Numerical-Analysis-Lab/Lab` or in the course root both work.

### Coauthorship analysis

```bash
cd InfoNetworks/pythonCoauthorship
python code.py --output-dir outputs
```

That writes `hw1solution.txt` and `plot1.pdf`–`plot4.pdf` into `outputs/`. I run
the manual-BFS version the same way:

```bash
cd InfoNetworks/pythonCoauthorship_customBFStree
python custom_bfs.py --output-dir outputs
```

Both entry points share the parsing and graph code in `coauthorship.py`; the
second one uses the explicit FIFO queue for Problems 3 and 4. They also share
`pythonCoauthorship/ps1data.txt`.

### HNL voter model

```bash
cd InfoNetworks/hnl_voter_model
python -m hnl_voter_model --nodes 100 --edges 20 --steps 100 --seed 42
python -m hnl_voter_model --dataset ../pythonCS6850_Project/PythonHybrid/sentimentdataset.csv --steps 50
```

### Machine-learning notebooks

```bash
python -m pip install -r "Machine Learning/requirements-ml.txt"
jupyter lab "Machine Learning/knn/knn.ipynb"
```

### MATH-Modeling notebooks

MATH-Modeling has its own requirements file and 74 notebooks:

```bash
cd MATH-Modeling
python3 -m venv .venv && source .venv/bin/activate
pip install -r requirements.txt
jupyter lab
```

Start with `notebooks/README.md`; it lists the ten topic folders in the order I
worked through them. The smaller lab subset in `../Numerical-Analysis-Lab/` uses
the root `requirements.txt`.

It also has a checker for notebooks, links, and data paths:

```bash
python "MATH-Modeling/scripts/check_repo.py"
```

### Exercise notebook

```bash
cd exercises
cp .env.example .env
# add GEMINI_API_KEY / SEMANTIC_SCHOLAR_API_KEY to .env
jupyter lab questions.ipynb
```

Task 1 only needs the local CSV/Parquet files. Task 2 needs a Gemini key, and
task 3 works without one at lower rate limits.

## Java

```bash
./CSCI\ 161/build.sh
./CSCI\ 161/test.sh
./CSCI\ 161/run.sh
```

The graphics programs write a PNG to `CSCI 161/out/` when there's no display.
`make java-test` runs the self-tests from the repo root.

## C++

```bash
make -C C++/hello-world
./C++/hello-world/build/hello-world
```

`make cpp-test` builds and runs it.

## R

I install the packages used by whichever scripts I'm working on. A superset:

```r
install.packages(c(
  "AER", "car", "coefplot", "dplyr", "ggplot2", "kableExtra", "knitr",
  "lattice", "lmtest", "matchingMarkets", "mfx", "palmerpenguins", "plm",
  "sandwich", "scatterplot3d", "Sleuth3", "stargazer"
))
```

Run a script from its own folder so it finds `_setup.R`:

```bash
cd "Applied-Statistics/R code"
Rscript "ANOVA Inference.R"
```

`_setup.R` loads `R/course_utils.R`, which gives the scripts:

- `read_data("snowPetrels.csv")` — find a course dataset;
- `read_external("sleep.txt")` — read a cached public dataset;
- `require_packages()` — stop early with an install command;
- `robust_summary(model)` — HC1 robust coefficient table.

I replaced the old course-local `summary(model, robust = TRUE)` calls with
`robust_summary()`. Base R silently ignores the `robust` argument, so the reports
I generated before the cleanup may show conventional standard errors. Re-run a
script if you need the robust ones.

`read_data()` searches the script folder and its parents for `csv files/`,
`Data/`, `data/`, `data/external/`, and `Project_3/`. That's why I run R scripts
from inside the course folder.

Two datasets never came with the course, and I didn't make them up:

| Dataset | Used by | How to supply it |
| --- | --- | --- |
| `roots.csv` (fine-root diameter/treatment) | `Effect Sizes.R`, `Reexpression.R`, `ANOVA and Regression with Indicators.R`, `effectSizes.R`, `reexpression-multipleComparison.R` | Put it in `Applied-Statistics/csv files/` |
| `distance.csv` (education vs distance) | `ECON284/Ed.R` | Set `ECON284_DISTANCE_DATA=/path/to/distance.csv` |

The choir scripts use `singerHeightsData.csv`, which is included. I cached the
five public statsci.org datasets (`insulgas`, `mazdas`, `sleep`, `punting`,
`hanford`) in `Applied-Statistics/data/external/` so the scripts run offline.

## Julia and Pluto

`Matrix Computations` has a `Project.toml`. Instantiate it once:

```bash
julia --project="Matrix Computations" -e 'using Pkg; Pkg.instantiate()'
```

The `.jl` files under `hw/` are Pluto notebooks. Start Pluto:

```bash
julia --project="Matrix Computations" -e 'using Pluto; Pluto.run()'
```

Then open, for example, `Matrix Computations/hw/hw1.jl`. The PDFs next to each
notebook are the write-ups I submitted.

The Bayesian-optimization tutorial has its own environment:

```bash
julia --project="Matrix Computations/bo-tutorial" -e 'using Pkg; Pkg.instantiate()'
julia --project="Matrix Computations/bo-tutorial" "Matrix Computations/bo-tutorial/src/bo-tutorial.jl"
```

Or open `vanilla_bo.ipynb` in Jupyter with a Julia kernel.

## SQL (PostgreSQL)

The `CS_5320` lab loads a CSV with psql's client-side `\copy`, so it doesn't need
server file permissions:

```bash
cd CS_5320
createdb bars
psql -d bars -f SQLfolder/bars.pgsql
```

Run it from `CS_5320`; the script uses the relative path
`csv/chocolate_bars.csv`. It creates the table and prints the answers to ten
labelled queries.

## Tableau

The `BI Systems` workbooks (`*.twb`) are XML; Tableau Desktop or Tableau Public
can open them. They point at local files from the original project, so
reconnect the data source if Tableau can't find it. The PDFs in
`BI Systems/done/` show the submitted dashboards.

## LaTeX

The category-theory notes use the included `quiver.sty`:

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
| Repo check | `make check` |

## Checks and common problems

`make check` validates notebook JSON, Python/R/Julia syntax, tracked junk,
relative Markdown links, and committed secrets. It also runs the MATH-Modeling
checker.

```bash
make check
make check-fast      # skip the R/Julia parsers
python3 tools/check_repo.py
```

Things that have tripped me up:

- **`Could not find 'roots.csv'`** — that dataset isn't in the repo; see the
  table above.
- **`Missing R package(s)`** — run the `install.packages(...)` line it prints.
- **A Pluto notebook won't start** — instantiate the Julia project first; the
  packages are in `Matrix Computations/Project.toml`.
- **`psql: connection … failed`** — start PostgreSQL or set `PGHOST`/`PGPORT`.
- **A notebook can't find `data/`** — launch it from inside
  `Numerical-Analysis-Lab`; the helper walks up to the folder with `data/`.
- **Tableau can't find the data** — edit the connection; the original project
  used local files.
