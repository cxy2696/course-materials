# Publication-data exercise

A three-part take-home exercise on messy publication data. It is intentionally
small and self-contained: one CSV/Parquet pair, one notebook, and raw API
responses for reproducibility.

## Tasks

| Task | Input | Output |
| --- | --- | --- |
| 1. Author productivity | `authors.csv`, `papers.parquet` | bar chart of papers per author |
| 2. Acknowledgement extraction | acknowledgement text | JSON names + reasons (Gemini API) |
| 3. Semantic Scholar sample | live API (100 papers) | `raw_papers.json`, `raw_papers.csv`, author-count plot |

## Run it

```bash
cd exercises
python -m venv .venv && source .venv/bin/activate
pip install -r requirements.txt
cp .env.example .env      # add GEMINI_API_KEY if you run task 2
jupyter lab questions.ipynb
```

`GEMINI_API_KEY` is required for task 2. `SEMANTIC_SCHOLAR_API_KEY` is optional;
the public endpoint works without a key at lower rate limits.

## Data notes

* `authors.csv` — one row per author with a (synthetic) ORCID identifier.
* `papers.parquet` — one row per paper; `Authors` is a list of dicts.
* `raw_papers.json` / `raw_papers.csv` — cached Semantic Scholar responses from
  the original run, kept so the plots can be reproduced without another call.

The ORCID values in the supplied data use the placeholder domain `xxxx.org` and
contain 22-character identifiers. The cleaning code therefore strips any URL
prefix and accepts ORCID-like strings rather than enforcing the real 16-digit
checksum.

## Security

An earlier version of `questions.ipynb` contained a hard-coded Google API key.
It has been removed, but it remains in the git history. **Revoke that key** and
read [`docs/security.md`](../docs/security.md) before reusing this material.
