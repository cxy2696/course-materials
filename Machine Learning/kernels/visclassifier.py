"""Decision-boundary visualisation for the SVM/perceptron notebooks."""

from __future__ import annotations

from collections.abc import Callable
from typing import Any

import matplotlib.pyplot as plt
import numpy as np


def visclassifier(
    fun: Callable[[Any], Any],
    xTr: np.ndarray,
    yTr: np.ndarray,
    w: np.ndarray | None = None,
    b: float = 0.0,
    resolution: int = 300,
) -> None:
    """Plots data points and the decision boundary of ``fun``.

    Parameters
    ----------
    fun:
        Callable that accepts an ``(n, 2)`` array/tensor and returns scores.
    xTr, yTr:
        Training points and labels.  Labels are expected to contain
        ``-1`` and ``+1``.
    w, b:
        Optional linear weights used to draw the normal vector.
    resolution:
        Grid resolution for the filled decision regions.
    """
    points = np.asarray(xTr, dtype=float)
    labels = np.asarray(yTr).reshape(-1)
    if points.ndim != 2 or points.shape[1] != 2:
        raise ValueError("xTr must have shape (n, 2)")
    if labels.shape[0] != points.shape[0]:
        raise ValueError("xTr and yTr must contain the same number of rows")

    class_values = np.unique(labels)
    marker_symbols = ["o", "x"]
    colors = [[0.5, 0.5, 1], [1, 0.5, 0.5]]

    x_range = np.linspace(points[:, 0].min(), points[:, 0].max(), resolution)
    y_range = np.linspace(points[:, 1].min(), points[:, 1].max(), resolution)
    grid_x, grid_y = np.meshgrid(x_range, y_range)
    grid = np.column_stack([grid_x.ravel(), grid_y.ravel()]).astype(np.float32)

    predictions = fun(grid)
    if hasattr(predictions, "detach"):
        predictions = predictions.detach().cpu().numpy()
    predictions = np.asarray(predictions).reshape(-1)
    if predictions.size != grid.shape[0]:
        raise ValueError("fun returned a different number of predictions than inputs")

    figure, axis = plt.subplots()
    axis.contourf(grid_x, grid_y, np.sign(predictions.reshape(grid_x.shape)), colors=colors)
    for index, value in enumerate(class_values):
        mask = labels == value
        axis.scatter(points[mask, 0], points[mask, 1],
                     marker=marker_symbols[index % len(marker_symbols)],
                     color="black", label=f"class {value}")

    if w is not None:
        weights = np.asarray(w, dtype=float).reshape(-1)
        if weights.size == 2:
            norm_squared = float(np.dot(weights, weights))
            if norm_squared > 0:
                alpha = -float(b) / norm_squared
                axis.quiver(weights[0] * alpha, weights[1] * alpha,
                            weights[0], weights[1], linewidth=2, color=[0, 1, 0])

    axis.axis("tight")
    axis.set_title("Decision boundary")
    figure.tight_layout()
    plt.show()
