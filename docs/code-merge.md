# Moving the `code` repository into this one

I had a separate [`cxy2696/code`](https://github.com/cxy2696/code) repository
with Java, machine-learning, MITx, R, C++, and practice notebooks. In November
2026 I merged it into this archive. The code now lives here; the old repository
is no longer the canonical copy.

## Where things went

| Old path | New path |
| --- | --- |
| `java/` | `CSCI 161/` |
| `python/machine_learning/` | `Machine Learning/` |
| `python/mitx_6_00_1x/` | `MITx 6.00.1x/` |
| `r/` | `INFO 4100/` |
| `cpp/` | `C++/` |
| `python/notebooks/` | `Practice Notebooks/` |
| `python/creative_project/` | `Creative Project (CS 3780-5780)/` |
| `python/hnl_voter_model/` | `InfoNetworks/hnl_voter_model/` |
| `python/coauthorship/` | Merged into `InfoNetworks/pythonCoauthorship/` |
| `python/tests/` | Split into `InfoNetworks/tests/` and `Machine Learning/tests/` |

I did not import the old git history. The files came in as one merge commit, so
deleting the old repository would also delete that history. I'll export a bundle
first if I ever need it.

## What I changed while merging

- The Java graphics helper writes headless output to `CSCI 161/out/` instead of
  `java/out/`.
- The coauthorship parser now accepts records without a citation-count column.
  The graph is 34,259 nodes / 96,582 edges, with a 25,269-node largest
  component; single-author papers stay as isolated nodes.
- I removed the duplicate 12 MB `ps1data.txt` from
  `InfoNetworks/pythonCoauthorship_customBFStree/`. Both entry points now use
  the file in `pythonCoauthorship/`.
- The HNL model uses the existing sentiment CSV in
  `InfoNetworks/pythonCS6850_Project/PythonHybrid/`; I didn't copy its duplicate
  data file or the two duplicate notebooks.
- I didn't copy the old repository's README, Makefile, docs, or CI workflow.
  The root README, `docs/`, `Makefile`, and `quality.yml` cover them.
- The HNL model, coauthorship parser, and ML utilities now have tests in the
  repo.

## How I check it

```bash
make check-code
python tools/check_repo.py --skip-code
```

`make check-code` runs 301 Java assertions, the C++ build, and 25 Python tests
(one optional PyTorch test is skipped when torch isn't installed).
