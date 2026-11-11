# Security

## Reporting a problem

If you find a credential, private data, or another security problem in this
repo, please contact me privately (see my GitHub profile) instead of opening a
public issue with the details.

## The key I committed

I left a Google API key in `exercises/questions.ipynb` and removed it from the
current tree in November 2026. **It is still in git history.** I need to revoke
it in Google Cloud; the full story and the optional history purge are in
[`docs/security.md`](docs/security.md).

## How I handle keys now

- Keys live in environment variables or a local `.env` that git ignores. Only
  `.env.example` with empty values is committed.
- I don't paste keys into notebooks, comments, shell examples, or output cells.
- I run `python3 tools/check_repo.py` before publishing; it scans tracked text
  for common key formats.
- I rotate first if something leaks. Deleting the file is secondary.

I should also turn on secret scanning and push protection in the repository
settings. They catch new keys at push time; they don't clean up old history.
