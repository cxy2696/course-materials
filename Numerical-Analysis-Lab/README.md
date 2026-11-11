# MATH 310 · Numerical Analysis Lab (2024)

Four labs and two projects from the numerical-analysis lab sequence. The work
covers root finding, floating-point/conditioning, climate-data calculus, LU
factorization with pivoting, PCA-based face recognition, Newton's method in
higher dimensions, and iterative linear solvers.

## What is inside

| Path | Description |
| --- | --- |
| `Lab/` | Canonical lab notebooks and the Lab 1 report |
| `Project/` | Project 1: multidimensional Newton's method (notebook, report, Markdown, CSS) |
| `Project_2 Iterative Methods for Solving Linear Systems.ipynb` | Project 2 notebook |
| `Iterative_Methods_for_Solving_Linear_Systems.pdf` | Project 2 report |
| `MultidimensionalNewtonMethod.html` | Rendered Project 1 write-up |
| `data/climate/` | `US-China.csv`, `maunaLoa.csv` |
| `data/faces/` | 41 face images (20 Taylor Swift, 20 Stallone, one mystery) |
| `data/audio/` | Four audio recordings for the audio lab |
| `AllLab/` | Working copies, audio experiments, and a face-recognition scratch notebook |
| `Lab 2_Climate Calculus.ipynb` | Earlier/alternate version of Lab 2 |

### Labs

| Lab | Topic | Notebook |
| --- | --- | --- |
| 1 | Basins of attraction (Newton's method) | `Lab/Lab 1_Basins of Attraction.ipynb` |
| 2 | Climate calculus (CO₂ trends, numerical differentiation/integration) | `Lab/Lab 2_Climate Calculus.ipynb` |
| 3 | LU factorization with partial pivoting | `Lab/Lab 3_LU Factorization with Partial Pivoting Lab.ipynb` |
| 4 | Face recognition with PCA | `Lab/Lab 4_Facial Recognition Lab.ipynb` |

### Projects

1. **Multidimensional Newton's method** — solve nonlinear systems, study
   convergence, and render the results.
2. **Iterative methods for linear systems** — Jacobi/Gauss–Seidel/SOR-style
   iterations, convergence, and error behavior.

## Run it

```bash
python -m pip install numpy pandas matplotlib scipy opencv-python jupyter
cd Numerical-Analysis-Lab/Lab
jupyter lab
```

The notebooks find the data folder by walking up from the current directory to
the folder that contains `data/`, so launching Jupyter in `Lab/` or in
`Numerical-Analysis-Lab/` both work. If you move a notebook, keep it inside the
course folder.

## What changed in the cleanup

* The Lab 4 notebook used hard-coded Windows paths
  (`F:\2024Sp\MATH310\...`); the face images now live in `data/faces/` and the
  notebook uses a `FACES` path.
* The climate notebooks downloaded CSV files from a personal GitHub raw URL;
  they now read `data/climate/`.
* The face-recognition scratch notebook used remote cocalc image URLs; it now
  reads `data/faces/`.
* The audio notebooks read bare `audio1.wav` names; audio now lives in
  `data/audio/` and outputs go to `outputs/`.
* Exact duplicate root copies of the Climate Calculus and FPU notebooks were
  removed; the `Lab/` versions are canonical.

## Notes

* `AllLab/` is a working folder, not a second canonical set. It retains the
  audio experiments (`Audio.ipynb`, `Audio Processing.ipynb`), `check.ipynb`,
  and a scratch face-recognition notebook.
* The face images are celebrity photos used only for the PCA exercise; see
  [`../docs/third-party-materials.md`](../docs/third-party-materials.md).
* The reports are the submitted PDFs; re-running a notebook may produce
  slightly different plots due to library versions.
