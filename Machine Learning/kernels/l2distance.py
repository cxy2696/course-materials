"""Euclidean distance matrices for the kernel/SVM assignment.

Accepts NumPy arrays or PyTorch tensors and returns the matching type.
"""

from __future__ import annotations

from typing import Any

import numpy as np

try:  # PyTorch is only needed for the notebook's tensor workflow.
    import torch
except ImportError:  # pragma: no cover - exercised only in minimal setups
    torch = None  # type: ignore[assignment]


def l2distance(X: Any, Z: Any | None = None) -> Any:
    """Returns the Euclidean distance matrix between rows of ``X`` and ``Z``.

    ``X`` may be a NumPy array or a PyTorch tensor.  Tensors produce a float
    tensor result; arrays produce a NumPy result.  When ``Z`` is omitted the
    distance matrix of ``X`` with itself is returned with a zero diagonal.

    Shapes are ``(n, d)`` and ``(m, d)``; the result is ``(n, m)`` where entry
    ``(i, j)`` is ``||X[i] - Z[j]||``.
    """
    if torch is not None and isinstance(X, torch.Tensor):
        array = X.detach().cpu().numpy()
        other = None if Z is None else (Z.detach().cpu().numpy() if isinstance(Z, torch.Tensor) else Z)
        distances = l2distance_numpy(array, other)
        return torch.as_tensor(distances, dtype=torch.float32)

    if torch is not None and isinstance(Z, torch.Tensor):
        Z = Z.detach().cpu().numpy()
    return l2distance_numpy(X, Z)


def l2distance_numpy(X: np.ndarray, Z: np.ndarray | None = None) -> np.ndarray:
    """NumPy implementation of :func:`l2distance`."""
    x = np.asarray(X, dtype=float)
    if x.ndim != 2:
        raise ValueError(f"X must be two-dimensional, got shape {x.shape}")

    if Z is None:
        z = x
        self_distance = True
    else:
        z = np.asarray(Z, dtype=float)
        if z.ndim != 2:
            raise ValueError(f"Z must be two-dimensional, got shape {z.shape}")
        if z.shape[1] != x.shape[1]:
            raise ValueError(f"X and Z must have the same feature count: {x.shape} vs {z.shape}")
        self_distance = False

    x_norm = np.sum(x * x, axis=1).reshape(-1, 1)
    z_norm = np.sum(z * z, axis=1).reshape(1, -1)
    squared = x_norm + z_norm - 2.0 * (x @ z.T)
    # Floating-point cancellation can produce tiny negative values.
    np.maximum(squared, 0.0, out=squared)
    distances = np.sqrt(squared)
    if self_distance:
        np.fill_diagonal(distances, 0.0)
    return distances
