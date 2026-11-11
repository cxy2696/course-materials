# Change log

## 2026-11-12 — code cleanup, performance pass, English documentation

Baseline: the two commits from the morning of 2026-11-12 (`2423701` for the layout, `0f7c4b0` for the first round of documentation and fixes).

I made this pass after reading the first version again. The documentation was in Chinese and read like a report, so I rewrote it in English in my own voice. I also went back through all 74 notebooks: several still had loops that were easy to vectorize, and re-running everything turned up a few real bugs.

### Documentation

- Rewrote `README.md`, the six folder indexes and the four `docs/` pages in first-person English. There is no Chinese text left in the repository.
- Added `docs/performance.md` with the before/after timings and the per-notebook list.
- Moved the "what I changed" notes out of the README and into this log.

### Code changes

**Vectorization**

| Area | What I replaced |
| --- | --- |
| Simulations | Eight notebooks drew one trial at a time. They now draw all trials at once: Craps (100,000 games), Roulette (1,000,000 spins), accept–reject, Box–Muller, the dice examples and the exponential transform. |
| PDE solvers | `HW08` and the 2D logistic diffusion example updated one grid point at a time; they now update a whole interior slice. |
| Linear algebra | `HW05` and the LU/QR notebooks used a Python loop for each row or column of the factorization. The row/column updates are vectorized, and the triangular solves use a dot product per row instead of an inner loop. |
| Fitting | The L1, L2 and minimax objectives are vectorized over the data. The polynomial-degree example uses `Chebyshev.fit`, which avoids the conditioning warning of a raw Vandermonde fit. |
| Goat problem | Replaced four incomplete attempts with the closed-form lens area plus Brent's method and a Monte Carlo check. |
| Cross-entropy | Rewrote the portfolio example as a logit-normal CE and the TSP as an edge-probability CE, with vectorized Sharpe ratios and tour distances. |

**Bugs fixed**

- `MidpointMethod.ipynb` and the ODE notebooks allocated the solution with `np.zeros_like(t)`. When `dt` was an integer, `t` was an integer array and every step was truncated; the arrays are now floats.
- `Euler's Method.ipynb` and `BackwardsEuler.ipynb` had two near-identical Euler functions, two convergence studies and a midpoint comparison that used the exact solution as if it were the derivative. Each notebook now has one implementation, one convergence plot and a midpoint comparison using $f(t,x)=-0.5x$.
- The QR notebook's "full SVD" helper stacked random columns onto $U$ and was not orthogonal. It now completes the basis with a QR factorization and checks $\lVert U^TU-I\rVert$.
- The SVD implementations used a fixed threshold for the rank. A numerically zero eigenvalue produced a singular value of about $10^{-9}$ and broke the extension of $U$; the rank test is now relative to the largest singular value.
- `HW06` used projection deflation on a non-symmetric matrix. It now uses the left eigenvector (Wielandt deflation), and the second pair is checked with a residual.
- `Bisection Method.ipynb` printed a warning when the endpoints did not bracket a root and then continued; it now raises `ValueError`. `Regula Falsi.ipynb` compared `sign(f(a))` with `sign(b)` instead of `sign(f(b))`.
- `Numerical Integration.ipynb` built its results table with the doubled `n` values in the `n` column. The table now has the original `n`, `2n`, the two step sizes and the two relative errors.
- `AdData.ipynb` evaluated the exponent and power fits through a hand-written expression that reused the name `x` for several different arrays. The fits now use `statsmodels` predictions, and the residual comparison uses RMSE.
- `HW08` relied on an `Nt` left over from an earlier cell. It is now defined where it is used.
- `LaplaceAndPoisson.ipynb` had three copies of the same `linear_system` draft, including two with empty right-hand sides. There is now one version for exercise 6.71 and one plot per section.

**Reproducibility**

- Every random example takes a seed (`np.random.default_rng(2024)`); the benchmark and timing code uses `time.perf_counter`.
- The Fourier examples and the simulation notebooks now produce the same figures on every run.

**Housekeeping**

- Normalized the kernel metadata for all notebooks and removed the empty cells.
- Removed unused imports and duplicate imports, and merged repeated helper definitions (LU, QR, power method, RK4) into one implementation per notebook.
- Replaced `np.matrix` with `np.ndarray` in `Linear Algebra.ipynb`, `LU Decomposition.ipynb`, `Solving Systems with LU.ipynb` and `Eigenvectors and Eigenvalues.ipynb`.
- Removed duplicate scratch cells in the Goat, SVD, power-method, Euler, backward-Euler and Laplace notebooks and kept one implementation each. The exercises themselves are unchanged.
- Regenerated the outputs of the notebooks I changed.

### Repository checker

I refactored `scripts/check_repo.py` to parse each notebook once and reuse the result for the data-path check. It also flags absolute POSIX paths, not only Windows ones. The output is the same for this repository, but the code is shorter and the check is stricter.

### Verification

- 74/74 notebooks run end to end with Python 3.13.2, NumPy 2.5.4, SciPy 1.18.1, pandas 3.1.1, Matplotlib 3.11.2 and statsmodels 0.15.0, without network access.
- `python scripts/check_repo.py` reports 0 errors and 0 warnings.
- The repository workflow runs the same checker on Ubuntu, so case-sensitive path problems are caught as well.

No material was deleted in this pass. The three files removed in the first pass (two byte-identical copies and one alternate scan) are still documented above, and the layout and renames from that pass are unchanged.
