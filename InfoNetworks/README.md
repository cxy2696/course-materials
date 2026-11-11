# CS 6850 · Information Networks Project (Fall 2024)

I did two projects for Information Networks in fall 2024. One was a
coauthorship analysis; the other was a hybrid-contagion simulation that I
compared with a real-world dataset.

## Coauthorship analysis

I originally wrote two near-duplicate scripts. During the cleanup I merged them
into one module and two thin entry points:

| File | What it does |
| --- | --- |
| `pythonCoauthorship/coauthorship.py` | Parser, graph, four analyses, plots, CLI |
| `pythonCoauthorship/code.py` | Entry point using NetworkX's BFS |
| `pythonCoauthorship_customBFStree/custom_bfs.py` | Entry point using an explicit FIFO queue |
| `pythonCoauthorship/explanation.docx` | My original write-up |
| `pythonCoauthorship/plot1.pdf`–`plot4.pdf` | Regenerated outputs |
| `pythonCoauthorship/hw1solution.txt` | Regenerated solution file |

### The parser bug I fixed

The original parser split each bibliography line on commas and then on `&`. That
works for multi-author papers, but for a single-author paper it swallowed the
year, citation count, and venue into the author name. The result was tens of
thousands of fake nodes and an inflated graph.

I changed it to read the four fields explicitly:

```
year  citations  venue  author1 & author2, title
```

The regenerated graph has 32,451 nodes and 96,755 edges, with a 25,523-node
largest component. Single-author papers are now isolated nodes, which is why the
degree distribution starts at 0. The old graph had about 85k nodes.

### Running it

```bash
cd InfoNetworks/pythonCoauthorship
python code.py --output-dir outputs
```

or:

```bash
cd InfoNetworks/pythonCoauthorship_customBFStree
python custom_bfs.py --output-dir outputs
```

Options: `--data ps1data.txt`, `--output-dir outputs`, `--root Gries`,
`--netid xc535`, `--manual-bfs`.

The input is the 12 MB `ps1data.txt` in `pythonCoauthorship/`; both entry points
use it. `networkx`, `matplotlib`, and `numpy` are in the root
`requirements.txt`.

## Hybrid-contagion project

`pythonCS6850_Project/` has the simulations and the real-world data:

| Path | What it is |
| --- | --- |
| `PythonHybrid/1_random_simulation.ipynb` | Random-network hybrid-contagion simulation |
| `PythonHybrid/2_real_world.ipynb` | Comparison with a real network |
| `PythonHybrid/real_world_dataset.ipynb` | Dataset exploration |
| `PythonHybrid/sentimentdataset.csv` | Sentiment/network data |
| `test.ipynb`, `../test.ipynb`, `../2_real_world_dataset.ipynb` | Working copies |

The final report is `cs6850_final_project.pdf`; the reaction paper is
`cs6850_ReactionPaper.pdf`.

## Notes

- The coauthorship homework is also summarized in
  [`../INFO_6850/README.md`](../INFO_6850/README.md).
- I regenerated the outputs after the parser fix. The old PDFs and solution file
  are replaced, so compare against the explanation's prose, not the old numbers.
- The only runtime dependencies for the coauthorship code are `numpy`,
  `matplotlib`, and `networkx`.
