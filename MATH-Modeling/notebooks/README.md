# Numerical analysis notebooks

These are the 33 notebooks I wrote for MATH 310. I put them in ten folders that follow the order I studied the material. The numbers in the file names are textbook exercise numbers, so they do not run in sequence.

I rewrote the loops where a vectorized NumPy expression was clearer and fixed the bugs I found while re-running everything. The mathematical statement of each exercise is unchanged.

## 01 Python and floating point

| Notebook | Exercises | What it does | Methods |
| --- | --- | --- | --- |
| [Intro to Python.ipynb](<01-python-and-floating-point/Intro to Python.ipynb>) | A.5, A.9 | Python basics: variables, functions and exceptions | appendix exercises |
| [Numpy and Scipy.ipynb](<01-python-and-floating-point/Numpy and Scipy.ipynb>) | 3.70–3.79 | NumPy array operations and numerical derivatives | `np.diff`, central differences, step-size trade-off |
| [Floating Point Arithmetic.ipynb](<01-python-and-floating-point/Floating Point Arithmetic.ipynb>) | — | How floating-point numbers round | machine epsilon, significant digits |

## 02 Root finding

| Notebook | Exercises | What it does | Methods |
| --- | --- | --- | --- |
| [Bisection Method.ipynb](<02-root-finding/Bisection Method.ipynb>) | 2.12, 2.13, 2.17 | Bisection with an explicit interval check | sign test, linear convergence |
| [Regula Falsi.ipynb](<02-root-finding/Regula Falsi.ipynb>) | 2.23–2.27 | Regula falsi and its convergence | secant intersection, false position |
| [Newton's Method and the Secant Method.ipynb](<02-root-finding/Newton's Method and the Secant Method.ipynb>) | Newton, secant | Derivations, implementations and comparison | tangent line, difference quotient |
| [Multidimensional Newton's Method.ipynb](<02-root-finding/Multidimensional Newton's Method.ipynb>) | — | Newton's method for a nonlinear system | Jacobian, `np.linalg.solve`, residual norm |

## 03 Linear algebra

| Notebook | Exercises | What it does | Methods |
| --- | --- | --- | --- |
| [Linear Algebra.ipynb](<03-linear-algebra/Linear Algebra.ipynb>) | 4.2–4.11 | Dot products, matrix products and elimination | hand-written product, matrix indexing |
| [LU Decomposition.ipynb](<03-linear-algebra/LU Decomposition.ipynb>) | 4.19–4.25 | LU factorization and elementary matrices | Doolittle, row operations, reconstruction check |
| [Solving Systems with LU.ipynb](<03-linear-algebra/Solving Systems with LU.ipynb>) | 4.28–4.33 | Forward and back substitution | triangular solves, residual check |
| [QR Factorization.ipynb](<03-linear-algebra/QR Factorization.ipynb>) | 4.41–4.47 | Gram–Schmidt QR | projection, orthogonality check |
| [Eigenvectors and Eigenvalues.ipynb](<03-linear-algebra/Eigenvectors and Eigenvalues.ipynb>) | 4.52, 4.60, 4.61 | Power iteration and deflation | Rayleigh quotient, projection deflation, residuals |
| [SVD.ipynb](<03-linear-algebra/SVD.ipynb>) | Exercise 1 | Written answers about the SVD and its inverse | $A = U\\Sigma V^T$, pseudoinverse |

## 04 Optimization

| Notebook | Exercises | What it does | Methods |
| --- | --- | --- | --- |
| [Optimization.ipynb](<04-optimization/Optimization.ipynb>) | 3.52, 3.53, 3.55, 3.63 | Derivative-free search, gradient descent, Monte Carlo | step size, convergence test, local minima |
| [Least Squares Optimization.ipynb](<04-optimization/Least Squares Optimization.ipynb>) | 3.81, 3.84 | Fitting a curve by minimizing the residual | `scipy.optimize.minimize`, sum of squares |
| [Newton's Method for Optimization.ipynb](<04-optimization/Newton's Method for Optimization.ipynb>) | — | Newton's method with backtracking | Hessian, descent direction, Armijo condition |

## 05 Function approximation

| Notebook | Exercises | What it does | Methods |
| --- | --- | --- | --- |
| [Approximating Functions.ipynb](<05-function-approximation/Approximating Functions.ipynb>) | 1.26–1.41 | Taylor, linear and quadratic approximations | truncation error, error bounds |

## 06 Numerical calculus

| Notebook | Exercises | What it does | Methods |
| --- | --- | --- | --- |
| [Numerical Differentiation.ipynb](<06-numerical-calculus/Numerical Differentiation.ipynb>) | 3.10–3.17 | First derivatives and truncation error | forward, backward and central differences |
| [Numerical Differentiation II.ipynb](<06-numerical-calculus/Numerical Differentiation II.ipynb>) | 3.23–3.29 | Higher derivatives and second-order formulas | three- and five-point stencils |
| [Numerical Integration.ipynb](<06-numerical-calculus/Numerical Integration.ipynb>) | 3.32–3.40 | Trapezoid and Simpson rules | composite rules, error halving |

## 07 Differential equations

| Notebook | Exercises | What it does | Methods |
| --- | --- | --- | --- |
| [Euler's Method.ipynb](<07-differential-equations/Euler's Method.ipynb>) | 5.5–5.13 | Explicit Euler and midpoint | local and global error |
| [BackwardsEuler.ipynb](<07-differential-equations/BackwardsEuler.ipynb>) | 5.48, 5.50 | Implicit Euler and stability | nonlinear solve at every step |
| [MidpointMethod.ipynb](<07-differential-equations/MidpointMethod.ipynb>) | 5.24, 5.32 | Midpoint method and convergence | average slope, log-log error plot |
| [RKmethod.ipynb](<07-differential-equations/RKmethod.ipynb>) | 5.35 | Classical RK4 and general four-stage methods | Butcher weights, convergence order |
| [Fitting ODE.ipynb](<07-differential-equations/Fitting ODE.ipynb>) | 5.58 | Fitting an ODE model to the boarding-school data | least squares over the rate constant |

## 08 Partial differential equations

| Notebook | Exercises | What it does | Methods |
| --- | --- | --- | --- |
| [HeatEquation.ipynb](<08-partial-differential-equations/HeatEquation.ipynb>) | 6.29 | Explicit scheme for the heat equation | FTCS, stability condition |
| [WaveEquation.ipynb](<08-partial-differential-equations/WaveEquation.ipynb>) | 6.46 | Explicit scheme for the wave equation | central differences, CFL condition |
| [LaplaceAndPoisson.ipynb](<08-partial-differential-equations/LaplaceAndPoisson.ipynb>) | 6.67, 6.71 | Turning Laplace/Poisson into a linear system | five-point stencil, boundary rows |
| [PDE.ipynb](<08-partial-differential-equations/PDE.ipynb>) | 6.6 | Comparing an analytic solution with snapshots and an animation | separation of variables, visualization |

## 09 Fourier analysis

| Notebook | Exercises | What it does | Methods |
| --- | --- | --- | --- |
| [DFT.ipynb](<09-fourier-analysis/DFT.ipynb>) | — | A DFT from the definition and its spectrum | complex exponential basis, frequency resolution |
| [DiscreteFourierTransform.ipynb](<09-fourier-analysis/DiscreteFourierTransform.ipynb>) | Exercise 1–2 | Fourier coefficients and partial sums | orthogonality, Gibbs phenomenon |
| [FFT.ipynb](<09-fourier-analysis/FFT.ipynb>) | Exercise 1–2 | FFT matrices and waveform spectra | divide and conquer, complexity |

## 10 Applications

| Notebook | Exercises | What it does | Methods |
| --- | --- | --- | --- |
| [Goat_Problem.ipynb](<10-applications/Goat_Problem.ipynb>) | — | How long a rope lets a goat reach half a circular pen | circle-intersection area, Brent's method, Monte Carlo check |

## Notes on the code

- I use the exercise numbers as labels, not as a reading order.
- The outputs are from my last full run. Re-running may change the last digits because library versions differ.
- Data files are read with relative paths from [`data/`](../data/).
- All notebooks use the standard `python3` kernel.
