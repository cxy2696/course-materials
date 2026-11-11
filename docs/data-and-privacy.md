# Data and privacy

I keep this repo public, so I've tried to be careful about what goes in it.
Course folders pick up things that were fine in private: interview transcripts,
names, grades, email threads, or data I don't have the right to republish.

This page is my own checklist. It is not legal advice.

## What I'm comfortable publishing

- Code, notes, reports, and problem-set solutions I wrote.
- The synthetic exercise data in `exercises/` (`authors.csv`,
  `papers.parquet`).
- Public datasets from statsci.org, the World Bank/MIGA, Kaggle, and AER, as
  long as I follow their terms.
- Public legal texts used in the RAG assignment
  (`AI in Organizations/hw4/docs/`).

## What I'd check before reusing

| Item | Why I'd look twice |
| --- | --- |
| `INFO_5355/Interview Recording (Anny)-…zip` | It has `interviewee-1.csv`, `interviewee-2.csv`, and `Activity Notes.xlsx` from a UX study. There may be names, quotes, or consent restrictions. |
| `INFO_5355/A1 Individual.docx`, `A2 Individual.docx`, `A5 Group.pdf` | Course submissions can include participant details or teammates' work. |
| `2025Spring/5940/Reflection*.docx`, exams | Mostly legal-case discussion, but a reflection can name someone. |
| `ECON411/`, `mobile-RPG-observation/` | The thesis data comes from public sources and Statista extracts; check the source terms before commercial reuse. |
| `BUS435/CoursePack/*.pdf`, `BI Systems/*.pdf` | Publisher case studies and course packs. Personal study only. |
| `Numerical-Analysis-Lab/data/faces/` | Celebrity photos used for the PCA lab. Course material; not for reuse outside the exercise. |

I'd also skim any PDF or slide deck for:

- student IDs, NetIDs, or grades;
- email addresses and phone numbers;
- quotes attributed to named interviewees;
- screenshots of private dashboards or company data;
- teammates' names and work.

## If I need to remove something

For a file that isn't sensitive, a normal delete is enough:

```bash
git rm --cached "path/to/file"
printf 'path/to/file\n' >> .gitignore
git commit -m "chore: remove private course file"
```

If the file is sensitive — interview data, a credential, personal information —
deleting it now isn't enough. The old blob is still in the pack and reachable
from earlier commits. I'd use `git filter-repo`, force-push, and tell anyone with
a clone to re-clone. The steps are in [`security.md`](security.md).

GitHub can keep cached views, forks, and search results for a while. Rotating a
secret or getting consent matters more than the rewrite.

## Where the data came from

I try to leave a source note next to each dataset:

- `Applied-Statistics/data/external/README.md` — the five statsci.org files.
- `Applied-Statistics/MIGA_Issued_Projects.csv` — World Bank/MIGA extract.
- `ECON411/DataCollection/` — Statista, World Bank, and anime-industry
  extracts; some file names still have the original statistic IDs.
- `CS_5320/csv/chocolate_bars.csv` — the chocolate-bar review data for the SQL
  lab.
- `InfoNetworks/pythonCoauthorship/ps1data.txt` — the bibliography extract for
  the CS 6850 assignment.
- `MATH-Modeling/data/README.md` — the five numerical-analysis datasets and
  their SHA-256 hashes.

If I add a dataset later, I'll add the URL, download date, and license in the
same place.
