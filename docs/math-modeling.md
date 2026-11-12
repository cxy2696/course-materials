# Moving MATH-Modeling into these notes

I had a separate [`MATH-Modeling`](https://github.com/cxy2696/MATH-Modeling)
repository for my numerical analysis, modeling, and optimization coursework.
In November 2026 I moved it into this archive at
[`MATH-Modeling/`](../MATH-Modeling/README.md) so everything is in one place.

## What moved

| Old path | New path |
| --- | --- |
| `notebooks/` | `MATH-Modeling/notebooks/` (33 notebooks, 10 topics) |
| `homework/` | `MATH-Modeling/homework/` (HW01–HW08 + SVD) |
| `modeling/` | `MATH-Modeling/modeling/` (14 lecture notes + 31 demos) |
| `projects/cross-entropy/` | `MATH-Modeling/projects/cross-entropy/` |
| `references/` | `MATH-Modeling/references/` (books, optimization notes, calculus handouts) |
| `data/` | `MATH-Modeling/data/` (five local datasets) |
| `docs/` | `MATH-Modeling/docs/` (provenance, maintenance, performance, changelog) |
| `scripts/check_repo.py` | `MATH-Modeling/scripts/check_repo.py` |
| `README.md`, `requirements.txt`, `.gitignore` | Kept in the folder |

I didn't copy `.github/workflows/check.yml`. GitHub only runs workflows from the
repository root, so I added the same check to
[`../.github/workflows/quality.yml`](../.github/workflows/quality.yml). I can
still run it by hand:

```bash
python "MATH-Modeling/scripts/check_repo.py"
```

## What I changed for the move

- I left the layout and the folder README alone so the 74 notebooks keep
  working. I only updated the clone instructions and added links to the smaller
  MATH 310 lab subset in [`../Numerical-Analysis-Lab/`](../Numerical-Analysis-Lab/README.md)
  and [`../Basins-of-Attraction/`](../Basins-of-Attraction/README.md).
- I changed `MATH-Modeling/scripts/check_repo.py` so links to the parent archive
  (`../README.md`, sibling course folders) are allowed. They're valid now that
  the folder is nested.
- I kept the folder's `requirements.txt` for standalone use. The root
  [`../requirements.txt`](../requirements.txt) has the same core packages plus
  the rest of the archive.
- I did not import the old git history. The files are in one commit here, and
  the old repository still has the history.
- The books and readings are still study material, as described in the folder
  README and `references/README.md`.

## What's in the folder

MATH 310 at the University of Puget Sound (spring 2024) is the main course:

| Folder | Topics |
| --- | --- |
| `notebooks/01`–`03` | Python, floating point, root finding, linear algebra |
| `notebooks/04`–`06` | optimization, function approximation, numerical calculus |
| `notebooks/07`–`09` | ODEs, PDEs, Fourier analysis |
| `notebooks/10` | the goat problem |
| `homework/` | eight problem sets plus an SVD write-up |
| `modeling/` | fitting, dynamical systems, simulation, graphs, games, queues, Markov chains |
| `projects/cross-entropy/` | cross-entropy optimization for a portfolio and a TSP |

## How I check it

```bash
python "MATH-Modeling/scripts/check_repo.py"
python tools/check_repo.py --skip-code
```

The first checks the 74 notebooks, 173 relative links, and four local data
references inside the folder. The second runs the repo-wide checks over the
merged tree.
