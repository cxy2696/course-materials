# Timing notes

I timed every notebook from a fresh kernel with `nbclient` on the same laptop, one run each. The numbers include kernel startup, which is usually 0.6–1.0 s, so a small notebook can look slow even when its code takes no measurable time. The total for all 74 dropped from 147 s to 96 s.

| Notebook | Before | After |
| --- | ---: | ---: |
| `homework/HW05.ipynb` | 26.64 s | 3.84 s |
| `notebooks/07-differential-equations/RKmethod.ipynb` | 15.18 s | 1.15 s |
| `notebooks/07-differential-equations/MidpointMethod.ipynb` | 9.21 s | 1.27 s |
| `homework/HW08.ipynb` | 4.51 s | 1.57 s |
| `modeling/code/simulation/Craps.ipynb` | 1.49 s | 0.69 s |
| `modeling/code/simulation/Roulette.ipynb` | 1.32 s | 0.60 s |
| `modeling/code/simulation/AcceptReject.ipynb` | 1.44 s | 0.97 s |
| `notebooks/03-linear-algebra/Linear Algebra.ipynb` | 1.66 s | 1.22 s |

`HW05` was slow because the LU and QR factorizations updated one entry at a time, and the notebook had four copies of the same solvers. I kept one copy, moved the row and column updates into NumPy, and used `solve_triangular` for the QR solve. `RKmethod` and `MidpointMethod` were slow because each ran the same convergence study twice at `dt` values down to $10^{-6}$; I removed the duplicate study and stopped at $10^{-4}$, which is enough to see the slope.

The simulations were drawing one trial at a time. They now draw the whole batch: 100,000 craps games, 1,000,000 roulette spins, a million accept–reject samples. The heat and logistic-diffusion solvers updated one grid point at a time; they now update the interior as a slice. The fitting notebooks had list comprehensions inside the objective, which I replaced with array expressions.

Two notebooks had a quieter bug. `MidpointMethod` and the ODE notebooks allocated the solution with `np.zeros_like(t)`. When `dt` was an integer, `t` was an integer array and each step was truncated. The arrays are now `dtype=float`, and the midpoint table matches the values in the notes instead of `[6, 3, 1, 0, …]`.

While re-running the linear algebra, I found that the QR notebook's "full SVD" helper was stacking random columns onto $U$ and that the SVD rank test used a fixed threshold. Neither showed up as an error; the reconstruction looked fine because the random columns were multiplied by zero singular values, but $U$ was not orthogonal. The helper now completes the basis with a QR factorization, the rank test is relative to the largest singular value, and the notebook prints $\lVert U^TU-I\rVert$ so the problem is visible if it returns.

The Goat notebook had four partial attempts. I replaced them with the closed-form lens area, a Brent solve for $A(r)=\pi/2$, and a Monte Carlo check. The cross-entropy project got the same treatment: the portfolio uses a logit-normal distribution and the TSP uses an edge-probability matrix, both vectorized, with a brute-force check for the four-city tour.

The rest was housekeeping: kernel metadata, empty cells, duplicate imports, unused imports, duplicate helper definitions, and `np.matrix` replaced with arrays. Every random example now has a seed, and the benchmark code uses `time.perf_counter`.

I did not vectorize the loops that are the method itself. Bisection, the time stepping in the ODE solvers and the Gram–Schmidt recurrence still have their loops; the notebooks are there to show how those loops work. The timings are a single run, and variations of a few tenths of a second mean nothing.
