# MATH 310 · Basins of Attraction (Spring 2024)

A standalone copy of the first numerical-analysis lab: visualize which roots
Newton's method reaches from each starting point, for real and complex
polynomials.

This project also appears in
[`../Numerical-Analysis-Lab/Lab/`](../Numerical-Analysis-Lab/Lab/), which is the
canonical multi-lab folder. The full MATH 310 course archive is in
[`../MATH-Modeling/`](../MATH-Modeling/README.md). The standalone copy is kept
because it was published separately (and linked from the old MATH310Lab site).

## What is inside

| File | Description |
| --- | --- |
| `Lab 1_Basins of Attraction.ipynb` | Main notebook: Newton iteration, grids of starting points, color-coded basins |
| `Lab 1 pieces.ipynb` | Scratch/working notebook with intermediate plots |
| `Lab_1_Basins_of_Attraction Report.pdf` | Submitted report (10 pages) |
| `README.md` | This guide |

## Run it

```bash
python -m pip install numpy matplotlib jupyter
jupyter lab "Lab 1_Basins of Attraction.ipynb"
```

The notebook is self-contained: it defines the polynomials, the Newton step, and
the grid evaluation. Outputs from the original run are retained.

## Notes

* “Basins of attraction” are the sets of initial guesses that converge to a
  particular root. The lab shows that the boundaries can be fractal and that
  convergence is sensitive to the initial guess.
* The report is the best place to start if you want the write-up rather than the
  code.
