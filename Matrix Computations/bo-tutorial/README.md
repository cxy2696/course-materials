# A Tutorial on Bayesian Optimization

I worked through this Julia tutorial while learning Bayesian optimization. It is
adapted from Peter Frazier's paper [*A Tutorial on Bayesian Optimization*](https://arxiv.org/abs/1807.02811).
The code builds the pieces from scratch: a lazy-evaluation helper, a trust-region
subproblem solver, radial-basis-function surrogates, test functions, and a
simple expected-improvement loop.

## What is inside

| Path | Description |
| --- | --- |
| `src/bo-tutorial.jl` | Driver that includes the other source files |
| `src/lazy_struct.jl` | `LazyStruct`, a small memoizing table |
| `src/optim.jl` | Trust-region subproblem solver |
| `src/rbf_surrogate.jl` | RBF kernels and surrogate model |
| `src/testfns.jl` | 1-D/2-D test functions and plotting helpers |
| `vanilla_bo.ipynb` | Notebook walkthrough with plots |
| `docs/frazier-bo-tutorial-paper.pdf` | The source tutorial paper |
| `docs/a_tutorial_on_bayesian_optimization.pdf` | A longer companion write-up |
| `Project.toml` | Julia environment (Plots, LinearAlgebra) |

## Run it

```bash
julia --project=. -e 'using Pkg; Pkg.instantiate()'
julia --project=. src/bo-tutorial.jl
```

Or open `vanilla_bo.ipynb` in Jupyter with a Julia kernel:

```bash
julia --project=. -e 'using Pkg; Pkg.add("IJulia")'
jupyter lab vanilla_bo.ipynb
```

The tutorial uses `Plots.jl` for figures; in a headless environment, set
`ENV["GKSwstype"] = "100"` before loading Plots or run the notebook with a
notebook front end.

## Reference

Frazier, P. I. (2018). *A Tutorial on Bayesian Optimization.* arXiv:1807.02811.
https://arxiv.org/abs/1807.02811

The Julia implementation in this folder is course/study code, not a production
optimization library.
