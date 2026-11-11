import sys
from pathlib import Path

import numpy as np
import pytest

PYTHON_ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(PYTHON_ROOT))
sys.path.insert(0, str(PYTHON_ROOT / "kernels"))
sys.path.insert(0, str(PYTHON_ROOT / "knn"))

from knn_utils import _normalize  # noqa: E402
from l2distance import l2distance_numpy  # noqa: E402


def test_l2distance_against_known_values():
    x = np.array([[0.0, 0.0], [3.0, 4.0]])
    z = np.array([[0.0, 0.0], [1.0, 0.0]])
    distances = l2distance_numpy(x, z)
    expected = np.array([[0.0, 1.0], [5.0, np.sqrt(20.0)]])
    assert np.allclose(distances, expected)


def test_l2distance_self_has_zero_diagonal():
    x = np.array([[0.0, 0.0], [1.0, 1.0], [3.0, 4.0]])
    distances = l2distance_numpy(x)
    assert distances.shape == (3, 3)
    assert np.allclose(np.diag(distances), 0.0)
    assert np.allclose(distances, distances.T)


def test_l2distance_rejects_bad_shapes():
    with pytest.raises(ValueError):
        l2distance_numpy(np.array([1.0, 2.0]))
    with pytest.raises(ValueError):
        l2distance_numpy(np.zeros((2, 2)), np.zeros((2, 3)))


def test_l2distance_accepts_torch_tensors():
    torch = pytest.importorskip("torch")
    x = torch.tensor([[0.0, 0.0], [3.0, 4.0]])
    distances = __import__("l2distance").l2distance(x)
    assert tuple(distances.shape) == (2, 2)
    assert float(distances[0, 1]) == pytest.approx(5.0)


def test_normalize_handles_constant_input():
    values = np.array([[1.0, 1.0], [1.0, 1.0]])
    assert np.allclose(_normalize(values), 0.0)
    assert np.allclose(_normalize(np.array([[0.0, 10.0]])), np.array([[0.0, 1.0]]))
