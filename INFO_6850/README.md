# INFO 6850 · Information Networks (Fall 2024)

I took Information Networks in fall 2024. The course covered random graphs,
power laws, small-world networks, spectral methods, random walks, expanders, and
network dynamics. I kept the problem sets, the lecture notes I took, and my
reaction paper.

## What's here

| Path | What it is |
| --- | --- |
| `hw1/` | Problem set 1 and the coauthorship write-up |
| `hw2/` | Problem set 2, the LaTeX source, and elimination-order worksheets |
| `notes/` | Notes on spectral methods, random walks, and random expanders |
| `reaction-paper.pdf` | My reaction paper on cascading behavior and voter models |
| `reactionpaperResources/` | The papers I cited (Granovetter, threshold models, voter-model variants, Kleinberg) |
| `random-expander.pdf`, `s2.pdf` | Other notes and handouts |
| `Python File Reading.pdf` | A guide to reading the assignment data |
| `The Structure of Information Networks (Jon Kleinberg).pdf` | The syllabus/overview |

## The code

The coauthorship problem-set code is in
[`../InfoNetworks/pythonCoauthorship/`](../InfoNetworks/pythonCoauthorship/).
It builds a graph from a 123k-line bibliography and reports the degree
distribution, connected components, BFS distances from a root author, and the
average potential parents per level.

```bash
cd InfoNetworks/pythonCoauthorship
python code.py --output-dir outputs
```

## Compiling the LaTeX

```bash
cd INFO_6850/hw2
pdflatex ps2.tex
```

## Notes

- Jon Kleinberg taught the course. The syllabus and readings are course
  material.
- The problem-set PDFs may contain instructor questions; the solutions and code
  are mine.
- `InfoNetworks/` has the full project version, including the hybrid-contagion
  simulations and final report.
