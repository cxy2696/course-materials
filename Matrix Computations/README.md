# CS 6210 · Matrix Computations (Fall 2025)

I took Matrix Computations in fall 2025. The course was numerical linear
algebra: floating-point error, LU/QR, least squares, eigenvalues, iterative
methods, and a little optimization. We wrote the homework in Julia, mostly as
Pluto notebooks.

## What I kept

| Path | What it is |
| --- | --- |
| `lecture/` | 27 lecture PDFs, August–December 2025 |
| `hw/` | Ten problem sets (`hw1.jl`–`hw10.jl`), midterm, final, and the matching PDFs |
| `final.jl`, `hw8.jl`, `hw9.jl`, `hw10.jl` | Earlier working copies of selected notebooks |
| `cs_6210.pdf` | Course notes/slides from David Bindel's 2019 offering |
| `2013 Matrix Computations 4th.pdf`, `Applied Numerical Linear Algebra 1st Edition.pdf` | Golub & Van Loan; Demmel |
| `bo-tutorial/` | A Bayesian-optimization tutorial in Julia |
| `Project.toml` | Julia environment for the problem sets |

The canonical problem sets are in `hw/` because that's where they sit next to
the submitted PDFs. The root-level `final.jl` and `hw8–10.jl` are earlier
versions that differ from the `hw/` copies; I kept them for history, not as the
entry points.

## Running the problem sets

The `.jl` files are Pluto notebooks, not plain scripts. Instantiate the project
once:

```bash
julia --project="Matrix Computations" -e 'using Pkg; Pkg.instantiate()'
julia --project="Matrix Computations" -e 'using Pluto; Pluto.run()'
```

Then open `hw/hw1.jl` (or any other) in the Pluto window.

If you'd rather use Jupyter, `bo-tutorial/vanilla_bo.ipynb` is a regular
notebook; it needs a Julia kernel (`IJulia`) and the tutorial environment.

## Bayesian-optimization tutorial

`bo-tutorial/` is adapted from Peter Frazier's *A Tutorial on Bayesian
Optimization* (arXiv:1807.02811). It has:

- `src/` — `LazyStruct`, a trust-region solver, an RBF surrogate, test
  functions, and the tutorial driver;
- `vanilla_bo.ipynb` — the notebook walkthrough;
- `docs/` — the paper and a longer companion PDF;
- `Project.toml` — Plots + LinearAlgebra.

```bash
julia --project="Matrix Computations/bo-tutorial" -e 'using Pkg; Pkg.instantiate()'
julia --project="Matrix Computations/bo-tutorial" "Matrix Computations/bo-tutorial/src/bo-tutorial.jl"
```

## Notes

- The textbook PDFs are course references.
- Pluto notebooks carry their own package imports. If a cell reports a missing
  package, add it to `Matrix Computations/Project.toml` and re-instantiate.
- The `hw/*.pdf` files are the write-ups I submitted; the `.jl` files are the
  code that produced them.
