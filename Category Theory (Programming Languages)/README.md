# Category Theory (Programming Languages) — Fall 2025

A reading seminar on category theory and its applications to programming-language
semantics: monads, fixed points of functors, algebraic theories, and type
theory. The folder is mostly papers and eight problem-set solutions, plus a
LaTeX document with commutative diagrams.

## What is inside

| Path | Description |
| --- | --- |
| `hw/a1-solution.pdf` … `hw/a8-solution.pdf` | Eight problem-set solutions |
| `hw/quiver-doc.tex`, `hw/quiver.sty` | LaTeX notes/examples using the `quiver` diagram package |
| `Basic Category Theory.pdf` | Tom Leinster's textbook |
| `AMM.pdf` | Adámek, Milius & Moss, *Fixed points of functors* |
| `Fixed points of functors.pdf` | Related fixed-point reading |
| `Moggi.pdf` | Moggi's monad-based semantics of computation |
| `Benton.pdf`, `Bauer.pdf`, `Métayer.pdf` | Type theory, computation, and categorical semantics readings |
| `PROOFS AND TYPES.pdf` | Girard's proof theory text |
| `Homotopy Type Theory- Univalent Foundations of Mathematics.pdf` | HoTT book |
| `cat.pdf`, `CategoryTheory.pdf`, `categories-for-types-byRoyCrole.pdf`, `SP.pdf`, `VVM.pdf`, `sized-types.pdf` | Additional lecture/reading material |

## Reading map

The likely order of the seminar, based on the files:

1. categories, functors, natural transformations (*Basic Category Theory*);
2. monads and computational effects (Moggi; Bauer; Benton);
3. fixed points and recursive types (AMM; *Fixed points of functors*);
4. categorical semantics of type theory (*Proofs and Types*; Roy Crole);
5. dependent types and univalent foundations (HoTT book);
6. sized types and termination (`sized-types.pdf`).

## Compiling the LaTeX notes

`hw/quiver-doc.tex` uses `tcolorbox` with `minted`, so compile with shell escape
and install Pygments first:

```bash
cd "Category Theory (Programming Languages)/hw"
python -m pip install Pygments
pdflatex -shell-escape quiver-doc.tex
pdflatex -shell-escape quiver-doc.tex
```

If you only want to read the solutions, the PDFs are already compiled; no LaTeX
installation is needed.

## Notes

* Every paper and textbook here is third-party material included for personal
  study. Do not redistribute it; see
  [`../docs/third-party-materials.md`](../docs/third-party-materials.md).
* The problem-set solutions are original work; the questions themselves may be
  from the instructor and are not always included.
