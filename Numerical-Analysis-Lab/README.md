# MATH 310 · Numerical Analysis Lab (2024)

I did these labs and projects for MATH 310. The work covers root finding,
floating-point and conditioning, climate-data calculus, LU with partial
pivoting, PCA face recognition, multidimensional Newton, and iterative linear
solvers.

This is the smaller lab/project subset. The full MATH 310 archive, with 33 topic
notebooks, eight problem sets, modeling notes, and a cross-entropy project, is
in [`../MATH-Modeling/`](../MATH-Modeling/README.md).

## What's here

| Path | What it is |
| --- | --- |
| `Lab/` | The lab notebooks and the Lab 1 report |
| `Project/` | Project 1: multidimensional Newton (notebook, report, Markdown, CSS) |
| `Project_2 Iterative Methods for Solving Linear Systems.ipynb` | Project 2 notebook |
| `Iterative_Methods_for_Solving_Linear_Systems.pdf` | Project 2 report |
| `MultidimensionalNewtonMethod.html` | Rendered Project 1 write-up |
| `data/climate/` | `US-China.csv`, `maunaLoa.csv` |
| `data/faces/` | 41 face images (20 Taylor Swift, 20 Stallone, one mystery) |
| `data/audio/` | Four audio recordings for the audio lab |
| `AllLab/` | Working copies, audio experiments, and a face-recognition scratch notebook |
| `Lab 2_Climate Calculus.ipynb` | An earlier version of Lab 2 |

### Labs

| Lab | Topic | Notebook |
| --- | --- | --- |
| 1 | Basins of attraction | `Lab/Lab 1_Basins of Attraction.ipynb` |
| 2 | Climate calculus | `Lab/Lab 2_Climate Calculus.ipynb` |
| 3 | LU with partial pivoting | `Lab/Lab 3_LU Factorization with Partial Pivoting Lab.ipynb` |
| 4 | Face recognition with PCA | `Lab/Lab 4_Facial Recognition Lab.ipynb` |

### Projects

1. **Multidimensional Newton's method** — solve nonlinear systems, study
   convergence, and render the results.
2. **Iterative methods for linear systems** — Jacobi/Gauss–Seidel/SOR-style
   iterations, convergence, and error behavior.

## Running it

```bash
python -m pip install numpy pandas matplotlib scipy opencv-python jupyter
cd Numerical-Analysis-Lab/Lab
jupyter lab
```

The notebooks find `data/` by walking up from the current directory, so starting
Jupyter in `Lab/` or in `Numerical-Analysis-Lab/` both work. If you move a
notebook, keep it inside the course folder.

## What I changed later

- Lab 4 used hard-coded Windows paths (`F:\2024Sp\MATH310\...`). The faces now
  live in `data/faces/`, and the notebook uses a `FACES` path.
- The climate notebooks downloaded CSVs from a personal GitHub raw URL. They now
  read `data/climate/`.
- The face-recognition scratch notebook used remote cocalc image URLs. It now
  reads `data/faces/`.
- The audio notebooks used bare `audio1.wav` names. Audio is in `data/audio/`,
  and outputs go to `outputs/`.
- I removed the exact duplicate root copies of the Climate Calculus and FPU
  notebooks; the `Lab/` versions are canonical.

## Notes

- `AllLab/` is a working folder, not a second canonical set. It keeps the audio
  experiments, `check.ipynb`, and a scratch face-recognition notebook.
- The face images are celebrity photos used only for the PCA exercise.
- The reports are the PDFs I submitted. Re-running a notebook may produce
  slightly different plots because of library versions.
