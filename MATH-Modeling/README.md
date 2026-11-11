# MATH-Modeling

> This folder is part of the [`course-materials`](../README.md) archive. It was migrated from the standalone [`cxy2696/MATH-Modeling`](https://github.com/cxy2696/MATH-Modeling) repository; the course layout and documentation are preserved so the notebooks keep working.

I keep my numerical analysis, mathematical modeling and optimization coursework here: the notebooks I wrote, my homework, the lecture notes I collected, and the reference books I used. I also added a small checker so the notebooks, links and data paths stay consistent as I revise them.

Most of the numerical-analysis notebooks come from **MATH 310 (Numerical Analysis)** at the University of Puget Sound, spring 2024. The exercise numbers in the file names follow that course's textbook. The modeling notes are from a separate modeling course, and the optimization books and lecture notes are reference material I studied alongside the courses. The smaller lab/project subset for the same MATH 310 course is in [`../Numerical-Analysis-Lab/`](../Numerical-Analysis-Lab/) and [`../Basins-of-Attraction/`](../Basins-of-Attraction/).

## What is here

| Folder | What it holds | Files |
| --- | --- | :---: |
| [`notebooks/`](notebooks/) | Numerical-analysis notebooks, in ten topic folders | 33 |
| [`homework/`](homework/) | Eight problem sets and one SVD write-up | 9 |
| [`modeling/`](modeling/) | Modeling lecture notes and short demo notebooks | 14 + 31 |
| [`projects/`](projects/) | A cross-entropy optimization project | 1 |
| [`references/`](references/) | Optimization, linear-programming and calculus references | 49 |
| [`data/`](data/) | Every dataset the notebooks read | 5 |
| [`docs/`](docs/) | Provenance, maintenance notes and change log | 4 |
| [`scripts/`](scripts/) | Repository checker | 1 |

## Running the notebooks

```bash
git clone https://github.com/cxy2696/course-materials.git
cd course-materials/MATH-Modeling

python3 -m venv .venv
source .venv/bin/activate          # Windows: .venv\Scripts\activate
pip install -r requirements.txt

jupyter lab
```

I wrote the notebooks with Python 3.8–3.12 and last ran them with Python 3.13, NumPy 2.5, SciPy 1.18 and Matplotlib 3.11. The saved outputs are from that run; use *Restart Kernel and Run All Cells* if you want outputs from your own versions.

The datasets are all in [`data/`](data/), so the notebooks run without a network connection.

## Layout

```text
MATH-Modeling/
├── notebooks/                 numerical analysis, in learning order
│   ├── 01-python-and-floating-point/
│   ├── 02-root-finding/
│   ├── 03-linear-algebra/
│   ├── 04-optimization/
│   ├── 05-function-approximation/
│   ├── 06-numerical-calculus/
│   ├── 07-differential-equations/
│   ├── 08-partial-differential-equations/
│   ├── 09-fourier-analysis/
│   └── 10-applications/
├── homework/                  HW01–HW08 and the SVD write-up
├── modeling/
│   ├── lecture-notes/         fitting, dynamical systems, simulation, graphs, games, queues, Markov chains
│   └── code/                  demos: fitting / dynamical-systems / simulation / markov-chains
├── projects/cross-entropy/    notebook, report and two runnable examples
├── references/
│   ├── books/                 optimization and operations-research books
│   ├── lecture-notes/         optimization notes and an SVD handout
│   ├── linear-optimization/   Math 407 notes
│   └── multivariable-calculus/ lecture notes, sections 12–16
├── data/                      local copies of every dataset
├── docs/                      provenance, maintenance, performance, change log
├── scripts/check_repo.py      offline checker
├── requirements.txt
└── README.md
```

## How I work through the material

I followed the numbered folders in order. Each one has a short index in [`notebooks/README.md`](notebooks/README.md) with the exercises it covers.

| Step | Topic | Entry point | What it covers |
| :---: | --- | --- | --- |
| 1 | Python and floating point | [`notebooks/01-python-and-floating-point/`](notebooks/01-python-and-floating-point/) | Python, NumPy/SciPy, machine precision and round-off |
| 2 | Root finding | [`notebooks/02-root-finding/`](notebooks/02-root-finding/) | bisection, regula falsi, Newton, secant, Newton for systems |
| 3 | Linear algebra | [`notebooks/03-linear-algebra/`](notebooks/03-linear-algebra/) | elimination, LU, QR, eigenvalues, SVD |
| 4 | Optimization | [`notebooks/04-optimization/`](notebooks/04-optimization/) | derivative-free search, gradient descent, least squares, Newton with line search |
| 5 | Function approximation | [`notebooks/05-function-approximation/`](notebooks/05-function-approximation/) | Taylor expansions, polynomial approximation, error bounds |
| 6 | Numerical calculus | [`notebooks/06-numerical-calculus/`](notebooks/06-numerical-calculus/) | finite differences, truncation error, trapezoid and Simpson rules |
| 7 | Differential equations | [`notebooks/07-differential-equations/`](notebooks/07-differential-equations/) | Euler, implicit Euler, midpoint, RK4, parameter fitting |
| 8 | Partial differential equations | [`notebooks/08-partial-differential-equations/`](notebooks/08-partial-differential-equations/) | heat, wave, Laplace/Poisson, finite differences |
| 9 | Fourier analysis | [`notebooks/09-fourier-analysis/`](notebooks/09-fourier-analysis/) | DFT, Fourier series, FFT |
| 10 | Applications | [`notebooks/10-applications/`](notebooks/10-applications/) | the goat problem: geometry plus a root finder |

The problem sets mirror the course sequence; [`homework/README.md`](homework/README.md) lists the exercises in each one.

## The notebooks

I grouped the 33 numerical-analysis notebooks into ten folders, numbered in the order I studied them. Each notebook keeps the derivation, the code and the figures from the original run. The full index with exercise numbers and methods is in [`notebooks/README.md`](notebooks/README.md).

## Homework

I kept eight problem sets (`HW01`–`HW08`) and one longer SVD implementation. They mix handwritten derivations with Python. See [`homework/README.md`](homework/README.md).

## Modeling notes

[`modeling/`](modeling/) holds the printed lecture notes I studied (modeling process, fitting, dynamical systems, simulation, graphs, decision analysis, game theory, queues, Markov chains) and 31 short notebooks that reproduce the examples. The index is in [`modeling/README.md`](modeling/README.md).

## Cross-entropy project

I wrote a small project on the cross-entropy method for optimization. It contains a notebook, the report, and runnable examples for a portfolio Sharpe-ratio problem and a four-city TSP. See [`projects/cross-entropy/`](projects/cross-entropy/).

## References

I collected the books and lecture notes in [`references/`](references/): five optimization and operations-research books, the Chinese optimization textbook and its errata, Burke's nonlinear-optimization notes, Peyré's optimization-for-machine-learning notes, the Math 407 linear-programming notes, and 29 multivariable-calculus handouts. Authors, editions and licences are listed in [`references/README.md`](references/README.md).

## Data

The five datasets are in [`data/`](data/); [`data/README.md`](data/README.md) records where each one came from and its SHA-256 hash. I replaced the original `raw.githubusercontent.com` reads with relative paths so the notebooks run offline.

## A pass over the code

I reran all 74 notebooks in November 2026 and fixed what broke. The simulations now draw their trials in one batch, and the PDE solvers update a whole grid row at a time; that is where most of the speed came from. The LU and QR routines do the same with their row and column updates. In the ODE notebooks the solution arrays were integers whenever `dt` was an integer, so every step was truncated; they are floats now. Some things were simply wrong: the QR "full SVD" helper stacked random columns onto $U$, the SVD rank test used a fixed threshold, the bisection check printed a warning and kept going, and regula falsi compared the wrong sign. I fixed those and added a reconstruction or residual check where it was cheap, so the output shows whether the result is right.

I also seeded every random example and replaced the remaining `np.matrix` code with arrays. Every notebook was re-executed afterwards, so the saved outputs come from the current code. [`docs/performance.md`](docs/performance.md) has the timings and the list of what changed where.

## Checking the repository

I run this before every push:

```bash
python scripts/check_repo.py
```

It checks that every notebook is valid JSON with Python kernels, that every Markdown link resolves, that the data paths in the code exist, and that there are no duplicate or empty files. The GitHub workflow runs the same script on Ubuntu, so a case-sensitive path problem shows up there too.

## Source notes

- The MATH 310 notebooks and the SVD handout are course material from the University of Puget Sound; the exercise data comes from the companion site of *Inquiry-Based Numerical Methods*.
- The books and lecture notes belong to their authors and publishers. I keep them for personal study only.
- `references/books/Algorithms for Optimization.pdf` is distributed under CC BY-NC-ND 4.0 (Kochenderfer and Wheeler, MIT Press, 2019) and is unmodified here.
- If you own material in this repository and would rather it were not public, open an issue and I will remove it.

More detail is in [`docs/provenance.md`](docs/provenance.md).
