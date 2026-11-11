"""Maximize a portfolio's Sharpe ratio with the cross-entropy method.

Run from the repository root:

    python projects/cross-entropy/examples/PortfolioProblem.py
"""

from __future__ import annotations

import numpy as np


def sharpe_ratios(samples: np.ndarray, expected_returns: np.ndarray,
                  covariance: np.ndarray, risk_free_rate: float = 0.0) -> np.ndarray:
    """Vectorized Sharpe ratio for a batch of weight vectors."""
    expected = samples @ expected_returns
    variance = np.einsum("ni,ij,nj->n", samples, covariance, samples)
    return (expected - risk_free_rate) / np.sqrt(variance)


def cross_entropy_portfolio(expected_returns: np.ndarray, covariance: np.ndarray,
                            num_samples: int = 4000, num_iterations: int = 100,
                            elite_fraction: float = 0.1,
                            risk_free_rate: float = 0.0,
                            seed: int = 2024) -> tuple[np.ndarray, float]:
    """Return (weights, Sharpe ratio) by CE over a logit-normal distribution."""
    rng = np.random.default_rng(seed)
    n = len(expected_returns)
    mean = np.zeros(n)
    std = np.ones(n)
    num_elite = max(1, int(num_samples * elite_fraction))
    best_weights, best_score = None, -np.inf

    for _ in range(num_iterations):
        z = rng.normal(mean, std, size=(num_samples, n))
        z -= z.max(axis=1, keepdims=True)
        weights = np.exp(z)
        weights /= weights.sum(axis=1, keepdims=True)

        scores = sharpe_ratios(weights, expected_returns, covariance, risk_free_rate)
        elite = np.argsort(scores)[-num_elite:]
        mean = z[elite].mean(axis=0)
        std = z[elite].std(axis=0) + 1e-4

        if scores[elite[-1]] > best_score:
            best_score = scores[elite[-1]]
            best_weights = weights[elite[-1]].copy()

    return best_weights, float(best_score)


def main() -> None:
    # Three illustrative assets: expected returns and annual covariance.
    expected_returns = np.array([0.12, 0.10, 0.15])
    covariance = np.array([[0.10, 0.02, 0.04],
                           [0.02, 0.08, 0.01],
                           [0.04, 0.01, 0.12]])

    weights, score = cross_entropy_portfolio(expected_returns, covariance)
    print("weights:", np.round(weights, 4))
    print("sum of weights:", f"{weights.sum():.6f}")
    print("Sharpe ratio:", f"{score:.4f}")


if __name__ == "__main__":
    main()
