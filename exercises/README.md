# Publication-data exercise

I worked through this as a take-home exercise. It has three parts: clean a
messy author/paper pair and plot papers per author, pull acknowledged names out
of a paragraph with the Gemini API, and sample papers from Semantic Scholar.

## The three tasks

| Task | What I start with | What I produce |
| --- | --- | --- |
| 1. Author productivity | `authors.csv`, `papers.parquet` | bar chart of papers per author |
| 2. Acknowledgement extraction | an acknowledgement paragraph | JSON names and reasons (Gemini) |
| 3. Semantic Scholar sample | the live API (100 papers) | `raw_papers.json`, `raw_papers.csv`, author-count plot |

## Running it

```bash
cd exercises
python -m venv .venv && source .venv/bin/activate
pip install -r requirements.txt
cp .env.example .env      # add GEMINI_API_KEY if I run task 2
jupyter lab questions.ipynb
```

`GEMINI_API_KEY` is required for task 2. `SEMANTIC_SCHOLAR_API_KEY` is optional;
the public endpoint works without a key at lower rate limits.

## About the data

- `authors.csv` — one row per author with a synthetic ORCID.
- `papers.parquet` — one row per paper; `Authors` is a list of dicts.
- `raw_papers.json` / `raw_papers.csv` — the Semantic Scholar responses I saved
  from the original run, so the plots can be reproduced without another call.

The ORCID values use the placeholder domain `xxxx.org` and 22-character IDs.
That's why my cleaning code strips any URL prefix and accepts ORCID-like
strings instead of enforcing the real 16-digit format.

## The key I left in the notebook

An earlier version of `questions.ipynb` had a hard-coded Google API key. I
removed it, but it's still in the git history. I still need to revoke it; the
notes are in [`../docs/security.md`](../docs/security.md).
