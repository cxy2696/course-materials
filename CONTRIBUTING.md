# Contributing

Thanks for taking a look at the archive. Corrections, clearer explanations, and
reproducibility fixes are welcome.

## Before you start

* Read the root [`README.md`](README.md) and
  [`docs/repository-conventions.md`](docs/repository-conventions.md).
* Check whether the course already has a `README.md`; update it rather than
  adding a parallel document.
* Do not add third-party textbooks, case studies, or datasets unless you have
  the right to redistribute them. See
  [`docs/third-party-materials.md`](docs/third-party-materials.md).
* Do not add personal data, interview transcripts, grades, or credentials. See
  [`docs/data-and-privacy.md`](docs/data-and-privacy.md).

## Reporting an issue

Open an issue with:

* the file or folder,
* what you expected and what happened,
* the command you ran,
* your Python/R/Julia version if relevant.

If the issue involves a leaked credential or private data, **do not open a
public issue**. Contact the maintainer privately; see
[`docs/security.md`](docs/security.md).

## Making a change

1. Fork or branch from `main`.
2. Keep the change focused: one documentation fix, one code fix, or one course
   addition per pull request.
3. Follow the existing conventions; new code should run from its own folder and
   avoid absolute paths.
4. Run the checks:

   ```bash
   make check
   # or, on a machine without R/Julia:
   make check-fast
   ```

5. Open a pull request with a short description and the commands you ran.

### Pull-request checklist

- [ ] The change is scoped to one course or one cross-cutting fix.
- [ ] Any new course folder has a `README.md`.
- [ ] New code has a docstring/header and a `main()`/entry point.
- [ ] Data paths are relative; no `file.choose()`, `/Users/...`, or `C:\...`.
- [ ] No keys, tokens, `.env` files, or personal data.
- [ ] `make check` passes (or the reason it cannot run is explained).
- [ ] The root README table and `docs/catalog.md` are updated for a new course.

## Adding a course README

Use this outline:

```markdown
# COURSE CODE · Course name (Term)

One or two sentences on the course and the folder's contents.

## Overview

What the course covered and what is worth looking at.

## What is inside

| Path | Description |
| --- | --- |
| `...` | ... |

## How to run it

```bash
# exact command
```

## Notes

Missing data, third-party material, known issues, collaborators.
```

## Commit messages

Use the imperative mood and an optional Conventional Commits prefix:

```
docs: clarify the R data lookup
fix(info-networks): handle single-author records
chore: remove duplicate archive
```

Avoid commits that mix formatting-only changes with behavioral changes; it
makes the history much easier to read.

## Code of conduct

Be respectful and assume good faith. This is a personal archive, not a formal
course, so maintainer response times will vary.
