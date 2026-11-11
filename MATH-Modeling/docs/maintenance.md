# MATH-Modeling conventions

The repository-wide layout and commit rules are in
[`../../docs/repository-conventions.md`](../../docs/repository-conventions.md).
This page only covers the numerical-analysis folder.

## Notebooks

1. Use the `python3` kernel and a minimal `language_info` block.
2. Read data with a relative path (`../../data/xxx.csv`), never an absolute path.
3. Seed random examples with `np.random.default_rng(...)`.
4. Allocate ODE solution arrays as floats: `np.zeros_like(t, dtype=float)`.
5. Vectorize when it makes the code shorter; keep the loop when the loop is the
   algorithm being taught (bisection, time stepping, Gram–Schmidt).
6. Re-run a notebook after changing its code so the saved output matches.
7. Keep notebooks below a few megabytes; trim redundant outputs if needed.
8. Do not write usernames, absolute paths, tokens, or private data into a notebook.

## Data and references

- New data goes in `data/`, with a row in `data/README.md` and a SHA-256 hash.
- Keep file names stable; update every reference if a file moves.
- Books and handouts go in `references/`, with author, edition, and licence in
  `references/README.md`.
- Keep `Algorithms for Optimization.pdf` unmodified (CC BY-NC-ND 4.0).

## Checks

```bash
python "MATH-Modeling/scripts/check_repo.py"
python "MATH-Modeling/scripts/check_repo.py" --strict
```

The checker validates notebook JSON and kernels, relative links, local data
paths, duplicate files, empty files, and OS junk. The root quality workflow runs
it on Ubuntu as well.

## Adding material

1. Put the file in the right folder and name it consistently.
2. Update the folder index and, for notebooks, the data path.
3. Run the checker.
4. Add a line to `docs/changelog.md` if the change is substantial.
