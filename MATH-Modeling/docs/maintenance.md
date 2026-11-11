# How I maintain this repository

These are the layout rules, conventions and checks I follow when I change something.

## Environment

```bash
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```

Every notebook uses the standard `python3` kernel. I do not commit virtual environments, `.ipynb_checkpoints/`, `.DS_Store` or editor files; `.gitignore` covers them.

## Layout

| Content | Where it goes |
| --- | --- |
| Numerical-analysis notebooks | `notebooks/<number>-<topic>/`, numbered 01–10 in learning order |
| Homework | `homework/`, named `HW01.ipynb`–`HW08.ipynb` |
| Modeling notes and demos | `modeling/lecture-notes/`, `modeling/code/<topic>/` |
| Projects | `projects/<project>/`, each with its own README |
| Books and external notes | `references/`, grouped by `books/`, `lecture-notes/`, `linear-optimization/`, `multivariable-calculus/` |
| Data | `data/`, flat |
| Notes about the repository | `docs/` |

If I add a top-level folder, I also update the layout table and the file tree in `README.md`.

## File names

- I use an English phrase that describes the content (`Bisection Method.ipynb`).
- I avoid `#`, parentheses and ampersands in file names. `HW#3.ipynb` became `HW03.ipynb` for exactly this reason.
- When two notebooks are versions of the same idea, I keep a suffix such as `II` or `Take 2` and explain the difference in the index.
- If a PDF arrives with a meaningless name, I rename it after its title page; if I am unsure what it is, I keep the original name and describe it in `references/README.md`.

## Notebook conventions

1. Use the `python3` kernel and the minimal `language_info` block.
2. Read data with a relative path (`../../data/xxx.csv`), never an absolute path.
3. Seed every random example with `np.random.default_rng(...)` so the saved output can be reproduced.
4. Allocate solution arrays as floats: `np.zeros_like(t, dtype=float)`. This matters when `dt` is an integer and `t` therefore has an integer dtype.
5. Prefer a vectorized update when it makes the code shorter and clearer. I keep an explicit loop only when the loop is the algorithm being taught (root finding, time stepping).
6. Keep a notebook's outputs consistent with its code. When I change a computation, I re-run the notebook.
7. Keep individual notebooks below a few megabytes. If a notebook grows past that, I trim redundant outputs or move the figures elsewhere.
8. Do not write usernames, absolute paths or tokens into a notebook.

## Data

- New data goes in `data/`, with a row in `data/README.md` and a SHA-256 hash.
- I keep the file name stable. If I must rename it, I update every reference and run the checker.
- I keep the original file where possible; cleaning steps belong in the notebook, not in an untraceable edit to the data.

## References

- When I add a book or a handout, I add it to the table in `references/README.md` with author, edition and licence.
- I only keep what I need for study. If I am unsure about the copyright status, I record the source and do not publish the file.
- *Algorithms for Optimization* is CC BY-NC-ND 4.0: keep it unmodified and keep the attribution.

## Checks before pushing

```bash
python scripts/check_repo.py
python scripts/check_repo.py --strict   # warnings fail too
```

The script checks:

- every notebook is valid nbformat 4 JSON and has a Python kernel;
- every relative Markdown link resolves to a file or directory;
- every local data path used in notebook code exists;
- there are no empty files, duplicate files or operating-system junk files;
- the top-level layout matches what `README.md` describes.

The GitHub workflow runs the same script on Ubuntu, which catches case mismatches that a case-insensitive macOS filesystem would hide.

## Commit messages

I use a scope and an action in the subject, then explain why in the body:

```text
notebooks: vectorize the simulation examples
data: add local copies of the exercise datasets
docs: rewrite the README in the first person
```

I keep moves and renames in one commit and content changes in another, so the history stays reviewable.

## Adding material

1. Put the file in the right folder and name it consistently.
2. If it is a notebook, make it run end to end from `data/`.
3. Update the index in that folder.
4. Add an entry to `docs/changelog.md`.
5. Run `python scripts/check_repo.py`.
6. Commit and push.
