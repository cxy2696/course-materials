# Documentation

This folder explains how the archive is organized, how to run it, and how to
maintain it.

| Document | What it covers |
| --- | --- |
| [`catalog.md`](catalog.md) | Every course, term, key files, languages, and datasets in one table |
| [`code-merge.md`](code-merge.md) | How the separate `code` repository was folded into this archive |
| [`running-code.md`](running-code.md) | Setup for Python, Java, C++, R, Julia, PostgreSQL, Tableau, and LaTeX; per-course commands |
| [`repository-conventions.md`](repository-conventions.md) | Folder layout, naming, code style, data policy, commit conventions |
| [`data-and-privacy.md`](data-and-privacy.md) | What data is public, what needs review, and how to handle interview material |
| [`third-party-materials.md`](third-party-materials.md) | Copyright status of readings, textbooks, slides, images, and datasets |
| [`security.md`](security.md) | The removed API key, revocation steps, and the secret-handling policy |

New here? Read the root [`README.md`](../README.md), then
[`catalog.md`](catalog.md), then the README of the course you care about.

Common tasks:

```bash
make check                  # validate notebooks, links, secrets, and syntax
make check-code             # Java, C++, and merged Python tests
make setup                  # install the Python analysis stack
python tools/check_repo.py  # run the checker directly
```

Each course folder also has a `README.md` with a short tour, the important
files, and the exact commands for that course.
