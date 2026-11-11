# INFO 6850 · Information Networks (Fall 2024)

Graduate course on the structure of information networks: random graphs, power
laws, small-world phenomena, spectral methods, random walks, expanders, and
network dynamics. The archive contains problem sets, lecture notes, a reaction
paper, and the companion code project.

## What is inside

| Path | Description |
| --- | --- |
| `hw1/` | Problem set 1 (`ps1.pdf`) and the coauthorship write-up (`explanation.docx`) |
| `hw2/` | Problem set 2 (`ps2.pdf`, `ps2.tex`) and elimination-order worksheets |
| `notes/` | Lecture notes: spectral methods, random walks, random expanders |
| `reaction-paper.pdf` | Reaction paper on cascading behavior / voter models |
| `reactionpaperResources/` | Papers cited in the reaction paper (Granovetter, threshold models, voter-model variants, Kleinberg) |
| `random-expander.pdf`, `s2.pdf` | Additional notes/handouts |
| `Python File Reading.pdf` | Guide to reading the assignment data |
| `The Structure of Information Networks (Jon Kleinberg).pdf` | Course syllabus/overview |

## Code

The coauthorship problem-set code lives in
[`../InfoNetworks/pythonCoauthorship/`](../InfoNetworks/pythonCoauthorship/).
It builds a graph from a 123k-line bibliography, reports the degree
distribution, connected components, BFS distances from a root author, and
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

* The course is taught by Jon Kleinberg at Cornell.
* The problem-set PDFs may contain instructor-provided questions; the solutions
  and code are original work.
* The `InfoNetworks` folder contains the full project version, including the
  hybrid-contagion simulations and final report.
