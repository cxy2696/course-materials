# Category Theory (Programming Languages) — Fall 2025

I took this as a reading seminar in fall 2025. We worked through basic category
theory, then monads, fixed points of functors, categorical semantics, and a bit
of type theory. I kept the papers and my eight problem-set solutions.

## What's here

| Path | What it is |
| --- | --- |
| `hw/a1-solution.pdf` … `hw/a8-solution.pdf` | My eight problem sets |
| `hw/quiver-doc.tex`, `hw/quiver.sty` | LaTeX notes with commutative diagrams |
| `Basic Category Theory.pdf` | Leinster's textbook |
| `AMM.pdf` | Adámek, Milius & Moss, *Fixed points of functors* |
| `Fixed points of functors.pdf` | More fixed-point reading |
| `Moggi.pdf` | Moggi on monads and computation |
| `Benton.pdf`, `Bauer.pdf`, `Métayer.pdf` | Type theory and categorical semantics |
| `PROOFS AND TYPES.pdf` | Girard's proof theory text |
| `Homotopy Type Theory- Univalent Foundations of Mathematics.pdf` | The HoTT book |
| `cat.pdf`, `CategoryTheory.pdf`, `categories-for-types-byRoyCrole.pdf`, `SP.pdf`, `VVM.pdf`, `sized-types.pdf` | Other readings |

The rough order was: categories and functors, monads, fixed points and
recursive types, categorical semantics, dependent types and HoTT, then sized
types and termination.

## Compiling the notes

`hw/quiver-doc.tex` uses `tcolorbox` with `minted`, so it needs shell escape and
Pygments:

```bash
cd "Category Theory (Programming Languages)/hw"
python -m pip install Pygments
pdflatex -shell-escape quiver-doc.tex
pdflatex -shell-escape quiver-doc.tex
```

If I only want the problem sets, the PDFs are already compiled.

## Notes

- The papers and textbooks are course readings; I kept them for study.
- The problem-set solutions are mine. The questions themselves came from the
  instructor and aren't always included.
