# Data and privacy

This repository is **public**. Course archives often accumulate material that
was fine in a private folder but should not be broadcast: interview transcripts,
names, grades, private correspondence, or licensed data. This page records what
is in the archive, what needs a second look, and how to remove something.

## What is definitely safe to publish

* Original code, notes, reports, and problem-set solutions written by the
  repository owner.
* Synthetic exercise data (`exercises/authors.csv`, `papers.parquet`).
* Public datasets from statsci.org, the World Bank/MIGA, Kaggle, AER, and
  similar sources — subject to their own terms.
* Public legal texts used in the RAG assignment (`AI in Organizations/hw4/docs/`,
  Cornell LII and health guidance).

## Needs review before redistribution

| Item | Concern | Recommendation |
| --- | --- | --- |
| `INFO_5355/Interview Recording (Anny)-20241004T002254Z-001.zip` | Contains `interviewee-1.csv`, `interviewee-2.csv`, and `Activity Notes.xlsx` from a UX interview study. May contain names, quotes, or consent-restricted material. | Confirm consent/IRB terms. If in doubt, remove the zip from the public repo and keep it in private storage. |
| `INFO_5355/A1 Individual.docx`, `A2 Individual.docx`, `A5 Group.pdf` | Course submissions may include participant details or teammates' work. | Review for personal data and credit co-authors. |
| `2025Spring/5940/Reflection*.docx`, exams | Reflections discuss legal cases, not people, but may include personal opinions. | Fine to publish unless a document names a private individual. |
| `ECON411/`, `mobile-RPG-observation/` | Thesis data compiled from public sources and Statista extracts. | Check the source terms before reusing the data commercially. |
| `BUS435/CoursePack/*.pdf`, `BI Systems/*.pdf` | Publisher case studies and course packs. | Personal study only. |
| `Numerical-Analysis-Lab/data/faces/` | Celebrity face images used for a PCA lab. | Course-provided images; do not reuse outside the lab context. |

Also review any presentation or PDF for:

* student IDs, NetIDs, or grades;
* email addresses and phone numbers;
* quotes attributed to named interview participants;
* screenshots of private dashboards or company data;
* teammates' names and contributions (credit them, and ask before publishing
  their work).

## If you need to remove something

For a single file that is not sensitive to history:

```bash
git rm --cached "path/to/file"
printf 'path/to/file\n' >> .gitignore
git commit -m "chore: remove private course file"
```

For a file that must disappear from **history** (interview data, a leaked
credential, personal information), a normal delete is not enough: the blob stays
in the pack and remains reachable from old commits. Use `git filter-repo`, then
force-push and ask collaborators to re-clone. See
[`security.md`](security.md) for a worked example.

After any removal, remember that GitHub may keep cached views, forks, and
search results for a while. Rotating the secret or obtaining consent is more
important than the rewrite itself.

## Data provenance

Where possible, each dataset is accompanied by a source note:

* `Applied-Statistics/data/external/README.md` — statsci.org datasets.
* `Applied-Statistics/MIGA_Issued_Projects.csv` — World Bank/MIGA extract.
* `ECON411/DataCollection/` — Statista, World Bank, and anime-industry
  extracts; filenames retain the original statistic IDs.
* `CS_5320/csv/chocolate_bars.csv` — chocolate-bar review dataset used in the
  SQL lab.
* `InfoNetworks/pythonCoauthorship/ps1data.txt` — bibliography extract for the
  CS 6850 assignment.

If you add a dataset, add a short `README.md` or a header comment with the URL,
download date, and license.

## Personal data in git history

Removing interview data or a credential from the current tree does not remove it
from earlier commits. The repository's history is part of the publication. If
you would not publish an old version of a file, purge it rather than only
deleting it.
