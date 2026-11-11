# Security policy

## Reporting a vulnerability

If you find a credential, private data, or another security issue in this
repository, please contact the maintainer privately (see the GitHub profile)
rather than opening a public issue with the details.

## Known incident

A Google API key was committed in `exercises/questions.ipynb` and removed from
the current tree during the November 2026 cleanup. **It remains in git history.**
Revoke the key in Google Cloud; see [`docs/security.md`](docs/security.md) for
the full incident notes and the optional history-purge procedure.

## Practices

* Secrets are read from environment variables or a local, git-ignored `.env`.
* `python3 tools/check_repo.py` scans tracked text files for common key formats.
* Pull requests should not add `.env` files, keys, tokens, personal data, or
  human-subjects material.
* Secret scanning and push protection should be enabled in the repository
  settings; they are not a substitute for rotating an exposed credential.
