# Security

## Incident: committed Google API key (fixed)

An earlier version of `exercises/questions.ipynb` contained a hard-coded Google
API key in a shell example (`X-goog-api-key: AIza…`). The key was committed in
`96e7d77` and was publicly visible while the repository was public.

**Status:** the key has been removed from the current notebook. It is **still
present in git history**, so removing it from the working tree is not enough.

### What to do now

1. **Revoke the key** in the [Google Cloud console](https://console.cloud.google.com/apis/credentials)
   (APIs & Services → Credentials). Deleting or rotating it is the only step
   that actually stops abuse.
2. Check the project's usage and billing for unexpected calls.
3. If the key came from a course or employer, tell the owner that it was
   exposed.
4. Optionally purge the key from git history (below), then force-push.

### Purge the key from history (optional after revocation)

Install [`git-filter-repo`](https://github.com/newren/git-filter-repo), then
create a local replacement file containing the literal key and a redaction:

```bash
# Do NOT commit this file. Copy the key from the notebook history.
printf '%s==>REDACTED_GOOGLE_API_KEY\n' 'THE_KEY_FROM_THE_OLD_NOTEBOOK' > /tmp/replacements.txt

git filter-repo --replace-text /tmp/replacements.txt
git push --force-with-lease origin main
```

History rewriting changes every commit hash. Coordinate with anyone who has a
clone or fork; they will need to re-clone. If the key is already revoked, the
rewrite is optional — the credential is useless even though the string remains.

### Harden the repository

Enable **secret scanning** and **push protection** in the GitHub repository
settings (Settings → Code security and analysis). They catch future key-shaped
strings at push time; they do not remove the existing history.

### Verification

```bash
git log --all -S 'AIza' --oneline       # should show only the old commit(s)
grep -rn 'AIza' --exclude-dir=.git .    # should be empty
python3 tools/check_repo.py             # secret scan
```

## Secret-handling policy

* Keys live in environment variables or a local `.env` file that is ignored by
  git. Commit only `.env.example` with empty values.
* Never paste a key into a notebook markdown cell, a code comment, a shell
  example, or an output cell.
* Use the smallest possible scope and rotate keys regularly.
* Before publishing, run `python3 tools/check_repo.py`; it scans for common
  key formats and private-key headers.
* If a secret is exposed, **rotate first**, then clean the repository. Deleting
  the file does not un-expose the secret.

## Other credentials

The exercise notebook reads `GEMINI_API_KEY` and `SEMANTIC_SCHOLAR_API_KEY` from
the environment; both are empty by default. The AI-in-Organizations notebooks
expect `OPENAI_API_KEY` (or equivalent) in the environment. No keys are stored
in the repository.

## Reporting a problem

If you find a credential or private data in this repository, please contact the
maintainer privately (see the GitHub profile for contact details) instead of
opening a public issue with the secret in it.
