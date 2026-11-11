# CS 6850 · Information Networks Project (Fall 2024)

Two projects for the information-networks course:

1. **Coauthorship analysis** — build a graph from a bibliography, measure its
   degree distribution and components, and explore BFS structure from a root
   author.
2. **Hybrid contagion** — simulate the spread of behavior in a network with
   both simple and complex contagion, then compare with a real-world dataset.

## Coauthorship analysis

The code was refactored from two near-duplicate scripts into one module plus two
thin entry points:

| File | Purpose |
| --- | --- |
| `pythonCoauthorship/coauthorship.py` | Parser, graph construction, four analyses, plotting, CLI |
| `pythonCoauthorship/code.py` | Entry point using NetworkX's BFS |
| `pythonCoauthorship_customBFStree/custom_bfs.py` | Entry point using an explicit FIFO-queue BFS |
| `pythonCoauthorship/explanation.docx` | Original write-up |
| `pythonCoauthorship/plot1.pdf`–`plot4.pdf` | Regenerated outputs |
| `pythonCoauthorship/hw1solution.txt` | Regenerated solution file |

### What changed

The original parser split each bibliography line on commas and then on `&`.
That works for multi-author papers, but for single-author papers it swallowed
the year, citation count, and venue into the author name — creating tens of
thousands of spurious nodes and inflating the graph. The new parser reads the
four fields explicitly:

```
year  citations  venue  author1 & author2, title
```

The regenerated graph has **32,451 nodes / 96,755 edges** (largest component
25,523) instead of the old inflated graph. Single-author papers are now included
as isolated nodes; that is why the degree distribution starts at 0 and why the
component-size table has many size-1 components. The original explanation
already noted that disconnected authors were being omitted.

### Run it

```bash
cd InfoNetworks/pythonCoauthorship
python code.py --output-dir outputs
# or
cd InfoNetworks/pythonCoauthorship_customBFStree
python custom_bfs.py --output-dir outputs
```

Options: `--data ps1data.txt`, `--output-dir outputs`, `--root Gries`,
`--netid xc535`, `--manual-bfs`.

The input is the 12 MB `ps1data.txt` (duplicated in the custom-BFS folder so
each folder is self-contained). `networkx`, `matplotlib`, and `numpy` are in the
root `requirements.txt`.

## Hybrid-contagion project

`pythonCS6850_Project/` contains the simulation notebooks and the real-world
dataset:

| Path | Description |
| --- | --- |
| `PythonHybrid/1_random_simulation.ipynb` | Random-network hybrid-contagion simulation |
| `PythonHybrid/2_real_world.ipynb` | Real-world network comparison |
| `PythonHybrid/real_world_dataset.ipynb` | Dataset exploration |
| `PythonHybrid/sentimentdataset.csv` | Sentiment/network dataset |
| `test.ipynb`, `../test.ipynb`, `../2_real_world_dataset.ipynb` | Working copies/scratch |

The final report is `cs6850_final_project.pdf`; the reaction paper is
`cs6850_ReactionPaper.pdf`.

## Notes

* The coauthorship homework is also summarized in
  [`../INFO_6850/README.md`](../INFO_6850/README.md).
* Outputs were regenerated after the parser fix; the old PDFs and solution file
  are replaced, so compare against the explanation's prose rather than old
  numbers.
* `numpy`/`matplotlib`/`networkx` are the only runtime dependencies for the
  coauthorship code.
