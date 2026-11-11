# MATH 310 · Basins of Attraction (Spring 2024)

I did this as the first lab in MATH 310. The idea is simple to state and fun to
look at: for each starting point, run Newton's method and color the point by
which root it reaches. The boundaries between colors are fractal.

I kept this as a separate folder because it was published on its own and linked
from the old MATH310Lab site. The canonical multi-lab folder is
[`../Numerical-Analysis-Lab/Lab/`](../Numerical-Analysis-Lab/Lab/), and the full
course archive is in [`../MATH-Modeling/`](../MATH-Modeling/README.md).

## What's here

| File | What it is |
| --- | --- |
| `Lab 1_Basins of Attraction.ipynb` | Main notebook: Newton iteration, grids of starting points, color-coded basins |
| `Lab 1 pieces.ipynb` | Scratch notebook with the intermediate plots |
| `Lab_1_Basins_of_Attraction Report.pdf` | The report I submitted |

## Running it

```bash
python -m pip install numpy matplotlib jupyter
jupyter lab "Lab 1_Basins of Attraction.ipynb"
```

The notebook is self-contained. It defines the polynomials, the Newton step, and
the grid evaluation; there are no data files. I kept the original outputs.

The report is the better place to start if you want the write-up rather than the
code.
