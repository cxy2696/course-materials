# Migrated MATH-Modeling archive

The standalone [`cxy2696/MATH-Modeling`](https://github.com/cxy2696/MATH-Modeling)
repository was folded into this archive in November 2026. The folder now lives
at [`MATH-Modeling/`](../MATH-Modeling/README.md) and is maintained here.

## What was migrated

| Original path | New location |
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

The original `.github/workflows/check.yml` was not copied: GitHub only runs
workflows from the repository root. Its job is now part of
[`../.github/workflows/quality.yml`](../.github/workflows/quality.yml), and the
same checker can be run locally:

```bash
python "MATH-Modeling/scripts/check_repo.py"
```

## Integration notes

* The folder keeps its original layout and README so the 74 notebooks continue
  to run unchanged. The README's clone instructions were updated for the
  parent archive, and cross-links were added to the smaller MATH 310 lab
  subset in [`../Numerical-Analysis-Lab/`](../Numerical-Analysis-Lab/README.md)
  and [`../Basins-of-Attraction/`](../Basins-of-Attraction/README.md).
* `MATH-Modeling/scripts/check_repo.py` was adjusted to allow links that point
  to the parent archive (`../README.md`, sibling course folders), which are
  valid now that the repository is nested.
* `requirements.txt` stays in the folder for standalone use; the root
  [`../requirements.txt`](../requirements.txt) has the same core packages plus
  the rest of the archive's Python stack.
* The source repository's history was not imported; the content is present in
  one commit here. The original repository remains available for history.
* The references and course readings are kept as study material, as described
  in the folder's `README.md` and `references/README.md`.

## Coverage

The MATH-Modeling archive is the full MATH 310 (University of Puget Sound,
spring 2024) sequence:

| Folder | Topics |
| --- | --- |
| `notebooks/01`–`03` | Python, floating point, root finding, linear algebra |
| `notebooks/04`–`06` | optimization, function approximation, numerical calculus |
| `notebooks/07`–`09` | ODEs, PDEs, Fourier analysis |
| `notebooks/10` | the goat problem (geometry + root finding) |
| `homework/` | eight problem sets plus an SVD write-up |
| `modeling/` | fitting, dynamical systems, simulation, graphs, games, queues, Markov chains |
| `projects/cross-entropy/` | cross-entropy optimization for portfolio Sharpe ratio and TSP |

## Verification

```bash
# from the repository root
python "MATH-Modeling/scripts/check_repo.py"
python tools/check_repo.py --skip-code
```

The first command validates the 74 notebooks, 185 relative links, and the four
local data references inside the folder. The second applies the repository-wide
checks (secrets, junk files, notebook JSON, Python syntax) to the merged tree.
