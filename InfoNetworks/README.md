# CS 6850 · Information Networks Project (Fall 2024)

Three pieces of work for the information-networks course:

1. **Coauthorship analysis** — build a graph from a bibliography and measure
   its degree distribution, components, and BFS structure.
2. **Hybrid contagion** — simulate simple and complex contagion in networks.
3. **HNL voter model** — a cleaned-up hypergraph voter model with latencies and
   a small command-line interface.

## Coauthorship analysis

| File | Purpose |
| --- | --- |
| `pythonCoauthorship/coauthorship.py` | Parser, graph construction, four analyses, plotting, CLI |
| `pythonCoauthorship/code.py` | Entry point using NetworkX BFS |
| `pythonCoauthorship_customBFStree/custom_bfs.py` | Entry point using an explicit FIFO queue |
| `pythonCoauthorship/hw1solution.txt` | Regenerated solution file |
| `pythonCoauthorship/plot1.pdf`–`plot4.pdf` | Regenerated plots |
| `pythonCoauthorship/explanation.docx` | Original write-up |

The parser expects `year`, `citation count`, `venue`, then authors (joined by
`&`) up to the first comma, then the title. It also accepts records without a
citation-count column. Records without enough fields are skipped; single-author
papers are kept as isolated nodes.

The current graph has **34,259 nodes / 96,582 edges** and a largest component of
**25,269** nodes. The old parser included year/venue text in single-author
names, which inflated the graph.

```bash
cd InfoNetworks/pythonCoauthorship
python code.py

cd ../pythonCoauthorship_customBFStree
python custom_bfs.py
```

Options: `--data`, `--output-dir`, `--root`, `--netid`, `--manual-bfs`. Both
entry points share `pythonCoauthorship/ps1data.txt` (12 MB).

## HNL voter model

`hnl_voter_model/` contains a binary-opinion voter model on a hypergraph:
weighted influence inside each hyperedge, a non-linearity exponent `q`, node
latencies, consensus stopping, JSON snapshots, CSV construction, plotting, and
tests.

```bash
cd InfoNetworks/hnl_voter_model
python -m hnl_voter_model --nodes 100 --edges 20 --steps 100 --seed 42

python -m hnl_voter_model \
  --dataset ../pythonCS6850_Project/PythonHybrid/sentimentdataset.csv --steps 50
```

The sentiment CSV is shared with the hybrid-contagion project. See
[`hnl_voter_model/README.md`](hnl_voter_model/README.md) for the model equations
and API.

## Hybrid-contagion project

`pythonCS6850_Project/PythonHybrid/` contains the simulation notebooks and the
sentiment dataset:

| Path | Description |
| --- | --- |
| `1_random_simulation.ipynb` | Random-network hybrid-contagion simulation |
| `2_real_world.ipynb` | Real-world network comparison |
| `real_world_dataset.ipynb` | Dataset exploration |
| `sentimentdataset.csv` | Sentiment/network dataset |

The final report is `cs6850_final_project.pdf`; the reaction paper is
`cs6850_ReactionPaper.pdf`. The coauthorship homework is also summarized in
[`../INFO_6850/README.md`](../INFO_6850/README.md).
