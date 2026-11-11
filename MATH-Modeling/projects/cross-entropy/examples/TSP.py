"""Solve a small travelling-salesman problem with the cross-entropy method.

Run from the repository root:

    python projects/cross-entropy/examples/TSP.py
"""

from __future__ import annotations

import itertools

import numpy as np


def route_distance(route, distance: np.ndarray) -> float:
    route = np.asarray(route)
    return float(distance[route, np.roll(route, -1)].sum())


def cross_entropy_tsp(distance: np.ndarray, num_samples: int = 1000,
                      num_iterations: int = 60, elite_fraction: float = 0.2,
                      learning_rate: float = 0.5, seed: int = 2024):
    """Return (best route, its length) sampled from an edge-probability matrix."""
    rng = np.random.default_rng(seed)
    n = distance.shape[0]
    probabilities = np.ones((n, n)) / (n - 1)
    np.fill_diagonal(probabilities, 0.0)
    best_route, best_distance = None, np.inf
    num_elite = max(1, int(num_samples * elite_fraction))

    for _ in range(num_iterations):
        routes = []
        for _ in range(num_samples):
            route = [0]
            unvisited = set(range(1, n))
            while unvisited:
                candidates = np.array(sorted(unvisited))
                p = probabilities[route[-1], candidates]
                p = p / p.sum()
                next_city = int(rng.choice(candidates, p=p))
                route.append(next_city)
                unvisited.remove(next_city)
            routes.append(route)

        distances = np.array([route_distance(r, distance) for r in routes])
        elite = np.argsort(distances)[:num_elite]

        frequency = np.zeros((n, n))
        for index in elite:
            route = routes[index]
            for a, b in zip(route, np.roll(route, -1)):
                frequency[a, b] += 1
        frequency /= num_elite

        probabilities = (1 - learning_rate) * probabilities + learning_rate * frequency
        np.fill_diagonal(probabilities, 0.0)
        probabilities /= probabilities.sum(axis=1, keepdims=True)

        if distances[elite[0]] < best_distance:
            best_distance = distances[elite[0]]
            best_route = routes[elite[0]]

    return best_route, float(best_distance)


def main() -> None:
    distance = np.array([[0, 10, 15, 20],
                         [10, 0, 35, 25],
                         [15, 35, 0, 30],
                         [20, 25, 30, 0]], dtype=float)

    route, length = cross_entropy_tsp(distance)
    print("best route:", route)
    print("route length:", length)

    optimum = min(route_distance(p, distance)
                  for p in itertools.permutations(range(distance.shape[0]))
                  if p[0] == 0)
    print("brute-force optimum:", optimum)


if __name__ == "__main__":
    main()
