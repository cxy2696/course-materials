# Cross-entropy method

I wrote this small project for a nonlinear-optimization course. It contains a seven-page report, one notebook and two runnable examples. The cross-entropy (CE) method turns optimization into repeated importance sampling: draw candidates from a distribution, keep the best fraction, refit the distribution to those elite samples, and repeat.

## Files

| File | What it is |
| --- | --- |
| [Cross-Entropy Method.ipynb](<Cross-Entropy Method.ipynb>) | The two experiments: portfolio Sharpe ratio and a four-city TSP |
| [Cross-Entropy Method.pdf](<Cross-Entropy Method.pdf>) | The report I wrote in December 2023: background, algorithm and results |
| [examples/PortfolioProblem.py](examples/PortfolioProblem.py) | Standalone portfolio example |
| [examples/TSP.py](examples/TSP.py) | Standalone TSP example with a brute-force check |

## Running it

```bash
cd projects/cross-entropy
jupyter lab "Cross-Entropy Method.ipynb"
```

or, from the repository root:

```bash
python projects/cross-entropy/examples/PortfolioProblem.py
python projects/cross-entropy/examples/TSP.py
```

Both examples need only NumPy.

## How the implementations work

- **Portfolio.** Weights live on the probability simplex. I sample a logit-normal vector and apply a softmax, so every candidate has positive weights that sum to one. The objective is the Sharpe ratio; the elite samples update the mean and standard deviation of the latent normal.
- **TSP.** A tour is sampled from an edge-probability matrix, starting at city 0. The elite tours update that matrix, with a learning rate that keeps some exploration. For four cities the result matches the brute-force optimum (length 80).

The notebook fixes the seed, so the saved output is reproducible. The report describes the method in more detail; the code here is the cleaned-up version I use for demonstrations.

## Caveats

This is a teaching implementation, not a production solver. The portfolio example uses a fixed covariance matrix and ignores transaction costs; the TSP example is limited to four cities so that the brute-force check is instant. For larger instances I would tune the sample size, elite fraction and smoothing, and I would not rely on a single run.
