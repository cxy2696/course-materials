# HNL voter model

I wrote this for the hybrid-contagion project: binary-opinion dynamics on a hypergraph. Each hyperedge contributes a weighted
influence score for both opinions; the scores are raised to `q` and turned into
an update probability. Node latencies limit how often a node can change. The run
stops when the largest opinion share reaches `consensus_threshold`.

This is the standalone version I used with the sentiment dataset; it is not the
notebook-local prototype.

## Files

```text
hnl_voter_model/
├── hnl_voter_model.py     # model, dataset loader, CLI
├── __main__.py            # python -m hnl_voter_model
├── models/*.json          # example snapshots
├── results/               # example plot
└── notebooks/sentiment-model.ipynb
```

Tests are in `../tests/test_hnl_voter_model.py`.

## Model

For a hyperedge $e$:

$$
S_0 = \sum_{i \in e, x_i=0} w_i,\qquad
S_1 = \sum_{i \in e, x_i=1} w_i
$$

$$
\tilde S_0 = S_0^q,\quad \tilde S_1 = S_1^q,\qquad
P(x_i \leftarrow 1) = \frac{\tilde S_1}{\tilde S_0+\tilde S_1}
$$

When the denominator is zero, the probability is 0.5. A node updates only if
$t - t_i^{\text{last change}} \ge \ell_i$. All hyperedges use the opinions from
the start of the step, so updates are synchronous.

`diversity = 1 - max(n0, n1)/n`; `cascade_size` is the share of nodes that
changed since the previous step; `mean_opinion` is the share with opinion 1.

## Usage

```bash
cd InfoNetworks/hnl_voter_model

# random hypergraph
python -m hnl_voter_model --nodes 100 --edges 20 --steps 100 --seed 42

# sentiment data shared with the hybrid-contagion project
python -m hnl_voter_model \
  --dataset ../pythonCS6850_Project/PythonHybrid/sentimentdataset.csv \
  --steps 50 --seed 42

# save a model and plot
python -m hnl_voter_model --nodes 100 --edges 20 --steps 100 --seed 42 \
  --save models/run.json --plot results/run.png

# load a snapshot
python -m hnl_voter_model --load models/hnl_voter_model.json --steps 10
```

Options: `--dataset`/`--load` (mutually exclusive), `--nodes`, `--edges`,
`--min-edge-size`, `--max-edge-size`, `--q`, `--threshold`, `--seed`, `--steps`,
`--save`, `--plot`, `--keep-running`, `--quiet`.

API:

```python
from hnl_voter_model import HNLVoterModel, generate_random_hypergraph
import numpy as np

nodes, edges = generate_random_hypergraph(50, 10, 2, 8, random_seed=1)
model = HNLVoterModel(
    nodes=nodes,
    hyperedges=edges,
    influence_weights=np.ones(50),
    q=1.5,
    latencies=np.ones(50, dtype=int),
    consensus_threshold=0.8,
    random_seed=1,
)
model.run(max_steps=50)
model.save("models/run.json")
```

## Dataset

`from_dataset()` reads `User`, `Sentiment`, `Hashtags`, `Retweets`, `Likes`, and
`Timestamp`. Users become nodes, hashtags become hyperedges, and each user's most
recent sentiment becomes the initial opinion. The bundled sentiment file has
**670 users and 173 hyperedges**; its initial positive share is about 0.815, so
the default 0.8 threshold stops at step 0. Raise `--threshold` or use a random
graph to see a longer run.

## Tests

From the repository root:

```bash
python -m pytest -q InfoNetworks/tests/test_hnl_voter_model.py
```

The tests cover validation, history, consensus stopping, save/load, random
hypergraphs, CSV construction, plotting, and invalid inputs.

## Notebook

`notebooks/sentiment-model.ipynb` is an older single-cell experiment with
classifiers. The simulation code in `hnl_voter_model.py` is the current version;
the other hybrid-contagion notebooks remain in
`../pythonCS6850_Project/PythonHybrid/`.
