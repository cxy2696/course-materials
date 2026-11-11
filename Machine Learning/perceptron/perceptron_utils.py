"""Helpers for the perceptron assignment: data loading and boundary plots."""

from __future__ import annotations

from pathlib import Path
from typing import Any

import matplotlib.pyplot as plt
import numpy as np


def loaddata(filename: str | Path) -> tuple[np.ndarray, np.ndarray, np.ndarray, np.ndarray]:
    """Loads ``xTr, yTr, xTe, yTe`` from a MATLAB ``.mat`` file.

    The returned matrices use the ``(n, d)`` layout expected by the notebook.
    """
    from scipy.io import loadmat

    data = loadmat(str(filename))
    required = {"xTr", "yTr", "xTe", "yTe"}
    missing = required.difference(data)
    if missing:
        raise ValueError(f"{filename} is missing variables: {sorted(missing)}")
    return (
        np.asarray(data["xTr"]).T,
        np.round(np.asarray(data["yTr"])).T,
        np.asarray(data["xTe"]).T,
        np.round(np.asarray(data["yTe"])).T,
    )


def visboundary(
    w: Any,
    b: float,
    xs: np.ndarray,
    ys: np.ndarray,
    resolution: int = 300,
) -> None:
    """Plots the linear boundary ``w · x + b = 0`` and the training points.

    Parameters
    ----------
    w:
        Two-dimensional weight vector (list, array, or tensor-like).
    b:
        Bias.
    xs:
        ``(n, 2)`` training points.
    ys:
        Labels in ``{-1, +1}``.
    resolution:
        Grid resolution of the filled decision regions.
    """
    weights = np.asarray(w, dtype=float).reshape(-1)
    if weights.size != 2:
        raise ValueError("w must contain exactly two weights")
    points = np.asarray(xs, dtype=float)
    labels = np.asarray(ys).reshape(-1)
    if points.ndim != 2 or points.shape[1] != 2:
        raise ValueError("xs must have shape (n, 2)")
    if labels.size != points.shape[0]:
        raise ValueError("xs and ys must contain the same number of rows")

    x_range = np.linspace(-5, 5, resolution)
    y_range = np.linspace(-5, 5, resolution)
    grid_x, grid_y = np.meshgrid(x_range, y_range)
    scores = grid_x * weights[0] + grid_y * weights[1] + float(b)

    figure, axis = plt.subplots()
    axis.contourf(grid_x, grid_y, np.sign(scores), colors=[[0.5, 0.5, 1], [1, 0.5, 0.5]])
    axis.scatter(points[labels == -1, 0], points[labels == -1, 1], marker="o", color="black")
    axis.scatter(points[labels == 1, 0], points[labels == 1, 1], marker="x", color="black")

    norm_squared = float(np.dot(weights, weights))
    if norm_squared > 0:
        alpha = -float(b) / norm_squared
        axis.quiver(weights[0] * alpha, weights[1] * alpha,
                    weights[0], weights[1], linewidth=0.8, color=[0, 1, 0])

    axis.set(xlim=(-5, 5), ylim=(-5, 5), title="Perceptron decision boundary")
    axis.axis("tight")
    figure.tight_layout()
    plt.show()
