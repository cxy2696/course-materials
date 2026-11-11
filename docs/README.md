# Notes about the repo

I keep the cross-course notes here: what I took, how to run it, and the small
rules I follow so the folders don't turn into a junk drawer.

| File | What I use it for |
| --- | --- |
| [`catalog.md`](catalog.md) | The semester-by-semester list of courses and what's in each one |
| [`running-code.md`](running-code.md) | Python, R, Julia, SQL, Java, C++, Tableau, and LaTeX setup |
| [`repository-conventions.md`](repository-conventions.md) | How I name things, where data goes, and what I check before pushing |
| [`data-and-privacy.md`](data-and-privacy.md) | What I'm comfortable publishing and what needs a second look |
| [`security.md`](security.md) | The API key I committed by mistake, and what I did about it |
| [`code-merge.md`](code-merge.md) | Where the old `code` repository ended up |
| [`math-modeling.md`](math-modeling.md) | Where the old `MATH-Modeling` repository ended up |

I'd start with the root [`README.md`](../README.md), then open the README of
the course you care about. The catalog is the quickest way to find a folder.

Commands I actually use:

```bash
make check                  # repo checks + MATH-Modeling checks
make check-code             # Java, C++, and Python tests
make setup                  # install the Python stack
python tools/check_repo.py  # just the repo checker
```
