# Merged `code` archive

The separate [`cxy2696/code`](https://github.com/cxy2696/code) repository was
folded into this archive in November 2026. The code is now maintained here;
the old repository is no longer the canonical location.

## Mapping

| Original `code` path | New location |
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

## History

The source repository's git history was not imported. The files were added to
this archive in one merge commit, so deleting the old repository would also
delete its commit history. Export a bundle first if that history matters.

## What changed during the merge

- The Java graphics helper now writes headless output to `CSCI 161/out/` instead
  of the old `java/out/`.
- The CS 6850 coauthorship parser accepts records without a citation-count
  column. The graph is now 34,259 nodes / 96,582 edges (largest component
  25,269); single-author papers are kept as isolated nodes.
- The duplicate 12 MB `ps1data.txt` in
  `InfoNetworks/pythonCoauthorship_customBFStree/` was removed. Both entry
  points share the file in `pythonCoauthorship/`.
- The HNL model uses the existing sentiment CSV in
  `InfoNetworks/pythonCS6850_Project/PythonHybrid/`; its duplicate data file and
  two duplicate notebooks were not copied.
- The source repository's own `README.md`, `Makefile`, `docs/`, and CI workflow
  were not copied. Their content is covered by this archive's README,
  `docs/`, `Makefile`, and `quality.yml`.
- Python tests for the HNL model, coauthorship parser, and ML utilities are now
  part of the repository test run.

## Verification

```bash
make check-code
python tools/check_repo.py --skip-code
```

`make check-code` runs 301 Java assertions, the C++ build, and 25 Python tests
(one optional PyTorch test is skipped when torch is not installed).
