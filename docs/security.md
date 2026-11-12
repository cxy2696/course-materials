# The API key I committed

I left a Google API key in `exercises/questions.ipynb` — it was pasted into a
shell example in one of the cells. It went into commit `96e7d77` while the repo
was public.

I removed it from the notebook during the November 2026 cleanup, but **it is
still in the git history**. Deleting the line from the current file doesn't
undo the exposure.

### What I need to do

1. Revoke the key in the [Google Cloud console](https://console.cloud.google.com/apis/credentials).
   Rotating or deleting it is the only thing that actually stops abuse.
2. Check the project's usage and billing for calls I don't recognize.
3. If the key was issued by a course or an employer, tell them it was exposed.
4. Optionally remove it from history (below), then force-push.

### Removing it from history

This is worth doing if I want the repo to be clean, but it changes every commit
hash. I'd install [`git-filter-repo`](https://github.com/newren/git-filter-repo)
and make a local replacement file with the literal key:

```bash
# Do not commit this file.
printf '%s==>REDACTED_GOOGLE_API_KEY\n' 'THE_KEY_FROM_THE_OLD_NOTEBOOK' > /tmp/replacements.txt

git filter-repo --replace-text /tmp/replacements.txt
git push --force-with-lease origin main
```

Anyone with a clone or fork will need to re-clone. If the key is already revoked,
the rewrite is optional — the credential is dead even if the string remains.

I should also enable **secret scanning** and **push protection** in the GitHub
repository settings (Settings → Code security and analysis). They catch new
key-shaped strings at push time; they don't clean up old history.

Quick checks:

```bash
git log --all -S 'AIza' --oneline       # should show only the old commits
grep -rn 'AIza' --exclude-dir=.git .    # should be empty
python3 tools/check_repo.py             # scans tracked text files
```

## How I handle keys now

- Keys go in environment variables or a local `.env` that git ignores. Only
  `.env.example` with empty values is committed.
- I don't paste a key into a notebook cell, a comment, a shell example, or an
  output cell.
- I use the smallest scope I can and rotate keys when a course is over.
- I run `python3 tools/check_repo.py` before publishing. It scans for common key
  formats and private-key headers.
- If I leak something, I rotate first. Removing the file is secondary.

The exercise notebook reads `GEMINI_API_KEY` and `SEMANTIC_SCHOLAR_API_KEY` from
the environment; both are empty by default. The AI-in-Organizations notebooks
expect `OPENAI_API_KEY` (or the provider named in the notebook) in the
environment. No keys are stored in the repo.

I keep this note here so I don't forget to revoke the key. The key is still in
history, even if the current notebook is clean.
