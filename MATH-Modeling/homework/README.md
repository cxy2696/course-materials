# Homework

I kept my eight problem sets and one longer SVD implementation here. Each notebook mixes the derivation with the code I used to check it. The exercise numbers match the textbook and the corresponding notebooks.

## Index

| Notebook | Exercises | Topic | What is in it |
| --- | --- | --- | --- |
| [HW01.ipynb](HW01.ipynb) | 1.43, 1.50, 1.51, 1.53, 1.58 | Floating point and iteration | even Fibonacci terms, Collatz lengths, floating-point equality, binary fractions and arithmetic |
| [HW02.ipynb](HW02.ipynb) | 2.51–2.54, 2.57, 2.63, 2.65 | Root finding | bisection, regula falsi, Newton and secant, with convergence comparisons |
| [HW03.ipynb](HW03.ipynb) | 3.97, 3.101, 3.103, 3.104 | Linear algebra and data | matrix computations; smoothing, numerical derivatives and trapezoid integration of water-quality data |
| [HW04.ipynb](HW04.ipynb) | 3.93–3.96, 3.106, 3.109 | Optimization | derivative-free search, gradient descent, Newton-type methods, convergence |
| [HW05.ipynb](HW05.ipynb) | 4.68, 4.72, 4.75, 4.78, 4.80, 4.81 | Linear systems | LU and QR solves, the heated-rod system, rank-deficient matrices, error growth with matrix size |
| [HW06.ipynb](HW06.ipynb) | 4.86, 4.90, 4.91 | Eigenvalues | power iteration, Wielandt deflation, Markov-chain steady state, a short SVD check |
| [HW07.ipynb](HW07.ipynb) | 5.73, 5.74, 5.76, 5.79 | Differential equations | coupled ODEs, orbits, the whale–krill model, a pendulum and the logistic equation |
| [HW08.ipynb](HW08.ipynb) | 6.85, 6.88, 6.91 | Partial differential equations | variable diffusivity, spatial convergence, two-dimensional logistic diffusion |
| [SingularValueDecomposition.ipynb](SingularValueDecomposition.ipynb) | — | Matrix factorization | an SVD built from the eigendecomposition of $A^T A$, checked on tall, wide and rank-deficient matrices |

## What I fixed while re-running them

- `HW03` used a Windows absolute path for the water-quality CSV. It now reads `../data/Water_Quality_Data.csv`.
- `HW03` called the removed `scipy.misc.derivative`. I replaced it with an explicit central difference and dropped rows with missing temperatures before fitting.
- `HW04` passed a one-element array into `quad` as integration bounds. I convert the radius to a scalar first.
- `HW05` had four copies of the LU solver. There is now one vectorized implementation, and the QR benchmark uses `solve_triangular` instead of a general solve.
- `HW06` repeated the power method five times. There is one implementation with a residual check, and deflation uses the left eigenvector so it works for a non-symmetric matrix.
- `HW08` updated the heat equation one grid point at a time. The interior is updated as a slice, which is both shorter and faster.
- The SVD write-up had six incomplete attempts. I replaced them with one implementation that checks reconstruction and orthogonality for rectangular matrices.

The outputs are from my last run. Re-running them with different library versions can change the last digits and the random examples, so I fixed the seeds.
