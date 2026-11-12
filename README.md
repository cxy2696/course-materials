# Course Materials

[![Quality checks](https://github.com/cxy2696/course-materials/actions/workflows/quality.yml/badge.svg)](https://github.com/cxy2696/course-materials/actions/workflows/quality.yml)

I keep my university coursework here: lecture notes, lab reports, problem sets,
slides, and the code and data behind them. Most of it is computer science, mathematics, economics, and business coursework, plus some programming practice.

I've tried to make the material easy to pick up. Each course has a README, data
paths are relative, and the public datasets I could cache are in the repo. At
the moment the repo has **1,083 tracked files**: 120 notebooks, 416 PDFs, and
229 code files across 25 course/code folders.

```bash
git clone https://github.com/cxy2696/course-materials.git
cd course-materials
make check          # notebooks, links, secrets, syntax
make check-code     # Java tests, C++ build, Python tests
```

## Courses

| Folder | What I did there | Main code |
| --- | --- | --- |
| [`2025Spring/`](<2025Spring/README.md>) | Eight Spring 2025 courses: probability, career prep, copyright, market design, materials KGs, history of AI, inference, statistical learning | R, Python, LaTeX |
| [`AI in Organizations/`](<AI in Organizations/README.md>) | INFO 1170/5170; built a creative chatbot prototype and compared a base model with a RAG assistant for law and healthcare | Python |
| [`Applied-Statistics/`](<Applied-Statistics/README.md>) | Regression and ANOVA labs, an energy-efficiency project, and a development-finance analysis | R |
| [`BI Systems/`](<BI Systems/README.md>) | INFO 4555/5556; dimensional models, WhereScape recipes, Tableau dashboards, and SQL exercises | SQL, Tableau |
| [`BUS435/`](<BUS435/README.md>) | International financial management; FX notes, case write-ups, and an AIFS hedging model | Python |
| [`Basins-of-Attraction/`](<Basins-of-Attraction/README.md>) | MATH 310 Lab 1; Newton's method on real and complex polynomials | Python |
| [`CS_5320/`](<CS_5320/README.md>) | Database systems; storage, indexes, query optimization, and a PostgreSQL lab | SQL |
| [`Category Theory (Programming Languages)/`](<Category Theory (Programming Languages)/README.md>) | A reading seminar: monads, fixed points, type theory, and eight problem sets | LaTeX |
| [`ECON284/`](<ECON284/README.md>) | Econometrics; class-size, wage, and beer-tax examples, plus homework and exams | R |
| [`ECON411/`](<ECON411/README.md>) | My econometrics thesis on mobile-RPG revenue and otaku culture | R, Python |
| [`INFO_5355/`](<INFO_5355/README.md>) | HCI design; usability assignments, interview guides, and an interview study | — |
| [`INFO_6850/`](<INFO_6850/README.md>) | Information networks; problem sets, spectral/random-walk notes, and a reaction paper | Python |
| [`InfoNetworks/`](<InfoNetworks/README.md>) | CS 6850 project; coauthorship graphs, hybrid-contagion simulations, and the HNL voter model | Python |
| [`Matrix Computations/`](<Matrix Computations/README.md>) | CS 6210; ten Pluto problem sets and a Bayesian-optimization tutorial | Julia |
| [`Numerical-Analysis-Lab/`](<Numerical-Analysis-Lab/README.md>) | MATH 310 labs on basins, climate data, LU, and PCA face recognition | Python |
| [`MATH-Modeling/`](<MATH-Modeling/README.md>) | My full MATH 310 archive: 74 notebooks, eight problem sets, modeling notes, and a cross-entropy project | Python |
| [`mobile-RPG-observation/`](<mobile-RPG-observation/README.md>) | The standalone version of my mobile-RPG thesis | R |

## Code and practice

| Folder | What I did there | Main code |
| --- | --- | --- |
| [`CSCI 161/`](<CSCI 161/README.md>) | Java labs from an intro course: console programs, sorting, cards, and graphics | Java |
| [`Machine Learning/`](<Machine Learning/README.md>) | Five assignments: kNN, perceptron, kernel SVM, naive Bayes, and SGD/CNN | Python |
| [`MITx 6.00.1x/`](<MITx 6.00.1x/README.md>) | Lecture code, handouts, and Problem Set 4 from MITx 6.00.1x | Python |
| [`INFO 4100/`](<INFO 4100/README.md>) | An R Markdown setup assignment | R |
| [`Practice Notebooks/`](<Practice Notebooks/README.md>) | Four short notebooks I kept for reference | Python |
| [`Creative Project (CS 3780-5780)/`](<Creative Project (CS 3780-5780)/README.md>) | An emotion-classification template and sample data | Python |
| [`C++/`](<C++/README.md>) | A small C++17 example with a Makefile | C++ |
| [`exercises/`](<exercises/README.md>) | A take-home exercise on messy publication data and two APIs | Python |

## Shared files

These are the files that apply to the whole repo rather than one course.

| Path | What it is |
| --- | --- |
| `docs/` | The catalog, running guide, conventions, privacy/security notes, and merge notes ([index](docs/README.md)) |
| `R/` | The helpers the R scripts share ([README](R/README.md)) |
| `tools/check_repo.py` | The repository checker I run before pushing |
| `Makefile` | `make check`, `make check-code`, `make setup`, and a few course-specific targets |
| `requirements.txt`, `requirements-ai.txt` | Python dependencies for the notebooks and the AI course |
| `.github/workflows/quality.yml` | CI: repo hygiene plus the Java, C++, and Python tests |
| `.editorconfig`, `.gitattributes`, `.gitignore` | Formatting, line-ending, and ignore rules |
| `CHANGELOG.md` | A log of the bigger passes over the repo |
| `SECURITY.md` | The key I committed by mistake and how I handle keys now |
| `LICENSE` | MIT for my code and writing |
| `README.md` | This index |

## Where to start

If you only open a few folders, I'd suggest:

- `InfoNetworks/pythonCoauthorship/` for the graph analysis and the parser fix;
- `MATH-Modeling/notebooks/` for the numerical-methods sequence;
- `Applied-Statistics/R code/` for the R labs;
- `Matrix Computations/hw/` for the Julia/Pluto homework;
- `AI in Organizations/hw4/` for the RAG comparison.

The semester-by-semester list is in [`docs/catalog.md`](docs/catalog.md), and
[`docs/running-code.md`](docs/running-code.md) has the setup for Python, R,
Julia, SQL, Java, C++, Tableau, and LaTeX.

## Checks

`make check` runs the repository checker and the MATH-Modeling checker. It
looks at notebook JSON, relative links, tracked junk, secrets, and Python/R/Julia
syntax. `make check-code` runs the Java self-tests, builds the C++ example, and
runs the Python tests.
