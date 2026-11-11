# Where the material comes from

This is my course work. I wrote down where each part came from so the sources are clear.

## Numerical analysis notebooks and homework

The notebooks in `notebooks/` and `homework/` are my work for **MATH 310 — Numerical Analysis** at the University of Puget Sound, spring 2024. I can point to three details:

- the SVD handout in `references/lecture-notes/` has “MATH 310 A Numerical Analysis” in the header and a `canvas.pugetsound.edu` course page in the footer;
- one homework notebook originally contained the absolute path `F:\2024sp\MATH310\...`;
- the exercise data came from the companion site of *Inquiry-Based Numerical Methods*, which is the site the course used.

The exercise numbers (`3.97`, `5.48`, …) are the textbook numbers. Some notebooks are titled only with the number; I added short descriptions to the indexes.

The original data URLs, now replaced by local copies:

```text
https://raw.githubusercontent.com/NumericalMethodsSullivan/NumericalMethodsSullivan.github.io/master/data/Exercise3_datafit1.csv
https://raw.githubusercontent.com/NumericalMethodsSullivan/NumericalMethodsSullivan.github.io/master/data/Exercise3_waterflow.csv
https://raw.githubusercontent.com/NumericalMethodsSullivan/NumericalMethodsSullivan.github.io/master/data/Exercise4_52.csv
https://raw.githubusercontent.com/NumericalMethodsSullivan/NumericalMethodsSullivan.github.io/master/data/Exercise5_boys.csv
```

`archive/ClassLectures.zip` is the bundle of lecture notebooks from January–April 2024 (59 files, including Sage backups). I keep it for comparison with the cleaned versions.

## Mathematical modeling notes and demos

The modeling handouts in `modeling/lecture-notes/` are the printed chapters I studied: the modeling process, fitting, experimental modeling, simulation, graphs, decision analysis, game theory, discrete dynamical systems, Markov chains and queueing. Chapters 16 and 17 are scans.

The notebooks in `modeling/code/` are my reproductions of the examples: stopping-distance fits, fishing and predator–prey models, random-number generators, and the brewery Markov chain. I wrote them to be short and runnable.

## Cross-entropy project

`projects/cross-entropy/` contains the report I wrote in December 2023, the notebook for the portfolio and TSP experiments, and two standalone example scripts. I rewrote the code in 2026 so the algorithms are vectorized and the results check out; the report is unchanged.

## References

| Category | Source |
| --- | --- |
| Optimization books | Kochenderfer and Wheeler (MIT Press, 2019); Boyd and Vandenberghe (Cambridge, 2004); Nocedal and Wright (Springer, 2nd ed., 2006); Winston (Duxbury, 4th ed.); the LINGO modeling text from LINDO Systems; the Chinese *Optimization: Modeling, Algorithms and Theory* and its errata |
| Optimization notes | James V. Burke (University of Washington), nonlinear optimization; Gabriel Peyré (CNRS/ENS), optimization for machine learning |
| Linear programming | Math 407, University of Washington |
| Multivariable calculus | Handouts numbered for chapters 12–16 |
| Operations research | Winston, *Operations Research: Applications and Algorithms* |

I left the books and handouts unchanged. Where a file name had a spelling mistake (`SensititvityAnalysis`, `operation-research-aplications`), I fixed the name and recorded it in the change log.

## Copyright and use

- The books, textbook chapters and course handouts belong to their authors and publishers. I keep them for personal study; this repository does not grant a licence to redistribute them.
- `references/books/Algorithms for Optimization.pdf` is published under **CC BY-NC-ND 4.0** (Kochenderfer and Wheeler, MIT Press, 2019). It is unmodified here.
- The exercise datasets come from a public textbook companion site and from data.gov. I keep them as they were published.
- If you own material here and would rather it were not public, open an issue and I will remove the file.

## How I organized the archive

I followed three rules:

1. **Keep the content.** Apart from three redundant files (two byte-identical copies and one alternate scan of the same book), I did not delete any material.
2. **Make moves traceable.** Every move and rename is in [`changelog.md`](changelog.md), and Git keeps the history.
3. **Do not change the mathematics.** I fixed code that no longer ran and consolidated duplicate implementations, but I did not change the statements or conclusions of the exercises.
