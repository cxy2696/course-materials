# CS 6210 · Matrix Computations (Fall 2025)

Graduate numerical linear algebra: matrix-vector products, floating-point error,
LU/QR factorizations, least squares, eigenvalues, iterative methods, and
optimization. The coursework is written in Julia, mostly as Pluto notebooks.

## What is inside

| Path | Description |
| --- | --- |
| `lecture/` | 27 lecture PDFs (August–December 2025) |
| `hw/` | Ten problem sets (`hw1.jl`–`hw10.jl`), midterm, final, and matching PDFs |
| `final.jl`, `hw8.jl`, `hw9.jl`, `hw10.jl` | Earlier working copies of selected notebooks |
| `cs_6210.pdf` | Course notes/slides (David Bindel's 2019 offering) |
| `2013 Matrix Computations 4th.pdf`, `Applied Numerical Linear Algebra 1st Edition.pdf` | Golub & Van Loan; Demmel |
| `bo-tutorial/` | Self-contained Bayesian-optimization tutorial in Julia |
| `Project.toml` | Julia environment for the problem sets |

The canonical problem sets are in `hw/` because they are paired with the
submitted PDFs. The root-level `final.jl` and `hw8–10.jl` are earlier versions
that differ from the `hw/` copies; they are kept for history, not as the entry
points.

## Run the problem sets

The `.jl` files are **Pluto notebooks** (they start with
`### A Pluto.jl notebook ###`), not plain scripts. Instantiate the project once:

```bash
julia --project="Matrix Computations" -e 'using Pkg; Pkg.instantiate()'
julia --project="Matrix Computations" -e 'using Pluto; Pluto.run()'
```

Then open `hw/hw1.jl` (or any other) in the Pluto window. Edit the cells and
run them; Pluto records the dependency graph.

If you prefer Jupyter, `bo-tutorial/vanilla_bo.ipynb` is a normal notebook; it
needs a Julia kernel (`IJulia`) and the tutorial environment.

## Bayesian-optimization tutorial

`bo-tutorial/` is adapted from Peter Frazier's *A Tutorial on Bayesian
Optimization* (arXiv:1807.02811). It includes:

* `src/` — `LazyStruct`, trust-region solver, RBF surrogate, test functions, and
  the tutorial driver;
* `vanilla_bo.ipynb` — a notebook walkthrough;
* `docs/` — the tutorial paper and a longer PDF;
* `Project.toml` — Plots + LinearAlgebra.

```bash
julia --project="Matrix Computations/bo-tutorial" -e 'using Pkg; Pkg.instantiate()'
julia --project="Matrix Computations/bo-tutorial" "Matrix Computations/bo-tutorial/src/bo-tutorial.jl"
```

## Notes

* The textbook PDFs are third-party material; see
  [`../docs/third-party-materials.md`](../docs/third-party-materials.md).
* Pluto notebooks contain their own package imports; if a cell reports a missing
  package, add it to `Matrix Computations/Project.toml` and re-instantiate.
* The `hw/*.pdf` files are the submitted write-ups; the `.jl` files are the
  code that produced them.
