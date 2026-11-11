"""Interactive plotting and data helpers for the k-NN assignment."""

from __future__ import annotations

from collections.abc import Callable
from pathlib import Path
from typing import Any

import matplotlib.pyplot as plt
import numpy as np


def loaddata(filename: str | Path) -> tuple[np.ndarray, np.ndarray, np.ndarray, np.ndarray]:
    """Loads ``xTr, yTr, xTe, yTe`` from a MATLAB ``.mat`` file.

    The arrays are transposed to the ``(n, d)`` convention used throughout the
    notebooks.
    """
    from scipy.io import loadmat

    data = loadmat(str(filename))
    required = {"xTr", "yTr", "xTe", "yTe"}
    missing = required.difference(data)
    if missing:
        raise ValueError(f"{filename} is missing variables: {sorted(missing)}")
    x_train = np.asarray(data["xTr"]).T
    y_train = np.round(np.asarray(data["yTr"])).T
    x_test = np.asarray(data["xTe"]).T
    y_test = np.round(np.asarray(data["yTe"])).T
    return x_train, y_train, x_test, y_test


def visualize_knn_2D(findknn: Callable[..., tuple[np.ndarray, np.ndarray]]) -> None:
    """Click-to-query 2-D k-NN visualiser.

    ``findknn(x, xTe, k)`` must return ``(indices, distances)`` where
    ``indices`` has shape ``(k, n_test)``.
    """
    rng = np.random.default_rng(7)
    points = rng.random((50, 2))
    neighbours = 5
    figure, axis = plt.subplots()
    axis.scatter(points[:, 0], points[:, 1], c="blue")
    axis.set(xlim=(0, 1), ylim=(0, 1), title="Click to add a test point")
    state: dict[str, Any] = {"test_point": None, "lines": None}

    def on_click(event: Any) -> None:
        if event.inaxes is not axis or event.xdata is None or event.ydata is None:
            return
        test_point = np.array([[event.xdata, event.ydata]])
        indices, _ = findknn(points, test_point, neighbours)
        state["test_point"] = test_point
        segments_x: list[float | None] = []
        segments_y: list[float | None] = []
        for index in range(neighbours):
            neighbor_index = int(np.asarray(indices)[index, 0])
            segments_x.extend([test_point[0, 0], points[neighbor_index, 0], None])
            segments_y.extend([test_point[0, 1], points[neighbor_index, 1], None])
        if state["lines"] is None:
            lines, = axis.plot(segments_x, segments_y, "r-")
            state["lines"] = lines
            axis.set_title(f"{neighbours}-nearest neighbours")
        else:
            state["lines"].set_data(segments_x, segments_y)
        if state.get("marker") is None:
            marker, = axis.plot(test_point[0, 0], test_point[0, 1], "ro")
            state["marker"] = marker
        else:
            state["marker"].set_data(test_point[0, 0], test_point[0, 1])
        figure.canvas.draw_idle()

    figure.canvas.mpl_connect("button_press_event", on_click)
    plt.show()


def visualize_knn_images(
    findknn: Callable[..., tuple[np.ndarray, np.ndarray]],
    imageType: str = "faces",
) -> None:
    """Click-to-cycle k-NN visualiser for the faces or digits dataset."""
    if imageType == "faces":
        x_train, y_train, x_test, y_test = loaddata(Path(__file__).with_name("faces.mat"))
        x_dim, y_dim = 38, 31
    elif imageType == "digits":
        dataset = Path(__file__).with_name("digits.mat")
        if not dataset.exists():
            raise FileNotFoundError("digits.mat is not included in this repository")
        x_train, y_train, x_test, y_test = loaddata(dataset)
        x_dim, y_dim = 16, 16
    else:
        raise ValueError("imageType must be 'faces' or 'digits'")

    x_test = _normalize(x_test)
    x_train = _normalize(x_train)
    figure = plt.figure(figsize=(8, 8))
    state = {"index": 0}

    def draw_page(_event: Any | None = None) -> None:
        figure.clear()
        index = state["index"] % len(x_test)
        slot = 1
        plt.subplot(4, 4, slot)
        plotimage(x_dim, y_dim, x_test[index].reshape(y_dim, x_dim).T, 2)
        plt.axis("off")
        plt.title("TEST")
        slot += 1

        indices, _ = findknn(x_train, np.asarray(x_test[index], ndmin=2), 3)
        for neighbor in range(3):
            plt.subplot(4, 4, slot)
            neighbor_index = int(np.asarray(indices)[neighbor, 0])
            plotimage(x_dim, y_dim, x_train[neighbor_index].reshape(y_dim, x_dim).T,
                      int(y_train.ravel()[neighbor_index] == y_test.ravel()[index]))
            plt.axis("off")
            plt.title(f"{neighbor + 1}-NN")
            slot += 1
        state["index"] += 1
        figure.canvas.draw_idle()

    draw_page(None)
    figure.canvas.mpl_connect("button_press_event", draw_page)
    print("Click on the images to cycle through the test images.")
    plt.show()


def plotimage(xdim: int, ydim: int, matrix: np.ndarray, color_channel: int = 2) -> None:
    """Plots one image with a coloured border."""
    image = np.zeros((xdim + 2, ydim + 2))
    image[1:-1, 1:-1] = matrix
    image = np.repeat(image[:, :, np.newaxis], 3, axis=2)
    image[[0, -1], :, color_channel] = 1
    image[:, [0, -1], color_channel] = 1
    plt.imshow(image, cmap=plt.cm.binary_r)


def plotfaces(X: np.ndarray, xdim: int = 38, ydim: int = 31) -> None:
    """Plots every row of ``X`` as a face image in a square grid."""
    count = X.shape[0]
    side = int(np.ceil(np.sqrt(count)))
    figure = plt.figure(figsize=(6, 6))
    for index in range(count):
        axis = figure.add_subplot(side, side, index + 1)
        axis.imshow(X[index].reshape(ydim, xdim).T, cmap=plt.cm.binary_r)
        axis.axis("off")
    figure.tight_layout()


def visualize_knn_boundary(
    knnclassifier: Callable[[np.ndarray, np.ndarray, np.ndarray, int], np.ndarray],
) -> None:
    """Interactive 2-D k-NN decision boundary.

    Left-click adds a positive point, right-click adds a negative point, and
    pressing ``h`` cycles through k values.
    """
    figure, axis = plt.subplots()
    axis.set(xlim=(0, 1), ylim=(0, 1), title="Left: +1, right: -1, h: change k")
    points: list[np.ndarray] = []
    labels: list[int] = []
    state = {"k": 1}
    resolution = 50

    def update() -> None:
        axis.clear()
        axis.set(xlim=(0, 1), ylim=(0, 1), title=f"k={state['k']}")
        for point, label in zip(points, labels):
            axis.plot(point[0], point[1], "or" if label == 1 else "ob")
        if len(points) >= 2:
            grid = np.linspace(0, 1, resolution)
            mesh_x, mesh_y = np.meshgrid(grid, grid)
            test_points = np.column_stack([mesh_x.ravel(), mesh_y.ravel()])
            k = min(state["k"], len(points))
            predictions = knnclassifier(np.asarray(points), np.asarray(labels).reshape(-1, 1),
                                        test_points, k)
            axis.contourf(mesh_x, mesh_y, np.asarray(predictions).reshape(mesh_x.shape),
                          colors=[[0.5, 0.5, 1], [1, 0.5, 0.5]])
            axis.set(xlim=(0, 1), ylim=(0, 1), title=f"k={k}")
        figure.canvas.draw_idle()

    def on_click(event: Any) -> None:
        if event.inaxes is not axis or event.xdata is None or event.ydata is None:
            return
        if event.button == 3:
            labels.append(-1)
        else:
            labels.append(1)
        points.append(np.array([event.xdata, event.ydata]))
        state["k"] = min(state["k"], len(points))
        update()

    def on_key(event: Any) -> None:
        if event.key == "h" and len(points) >= 2:
            state["k"] = state["k"] % len(points) + 1
            update()

    figure.canvas.mpl_connect("button_press_event", on_click)
    figure.canvas.mpl_connect("key_press_event", on_key)
    plt.show()


def _normalize(values: np.ndarray) -> np.ndarray:
    minimum = float(np.min(values))
    maximum = float(np.max(values))
    if maximum == minimum:
        return np.zeros_like(values, dtype=float)
    return (values - minimum) / (maximum - minimum)
