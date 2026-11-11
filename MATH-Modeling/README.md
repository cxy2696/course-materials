# MATH-Modeling

> I moved this folder out of my standalone [`cxy2696/MATH-Modeling`](https://github.com/cxy2696/MATH-Modeling) repo and into [`course-materials`](../README.md) in November 2026. I kept the layout and docs so the notebooks keep working.

This is my MATH 310 (Numerical Analysis) and mathematical-modeling coursework:
notebooks, problem sets, lecture notes, and reference books. The numerical
analysis part is from the University of Puget Sound, spring 2024; the smaller
MATH 310 lab/project subset is in [`../Numerical-Analysis-Lab/`](../Numerical-Analysis-Lab/)
and [`../Basins-of-Attraction/`](../Basins-of-Attraction/).

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
