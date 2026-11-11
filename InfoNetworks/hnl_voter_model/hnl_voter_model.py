"""Hybrid non-linear latency (HNL) voter model on a hypergraph.

Each node has a binary opinion. A step computes the weighted influence of both
opinions inside every hyperedge, raises the two sums to ``q``, and updates
eligible nodes with the resulting probability. The optional ``latencies``
limit how often a node can change. A run stops when the largest opinion share
reaches ``consensus_threshold``.

The module also loads the sentiment CSV used by the notebooks and provides a
small command-line interface.
"""

from __future__ import annotations

import argparse
import json
import logging
from collections import defaultdict
from collections.abc import Sequence
from pathlib import Path
from typing import Any

import numpy as np

LOGGER = logging.getLogger(__name__)

#: Sentiment labels treated as opinion 1 (positive); everything else is 0.
POSITIVE_SENTIMENTS = frozenset(
    {
        "positive", "happy", "joy", "happiness", "love", "amusement", "enjoyment",
        "admiration", "affection", "awe", "surprise", "adoration", "anticipation",
        "calmness", "excitement", "kind", "pride", "acceptance", "elation",
        "euphoria", "contentment", "serenity", "gratitude", "hope", "empowerment",
        "compassion", "tenderness", "arousal", "enthusiasm", "fulfillment",
        "reverence", "satisfaction", "curiosity", "mischievous",
    }
)

#: Sentiment labels treated as opinion 0 (negative).
NEGATIVE_SENTIMENTS = frozenset(
    {
        "negative", "anger", "fear", "sadness", "disgust", "disappointed",
        "bitter", "confusion", "shame", "despair", "grief", "loneliness",
        "jealousy", "resentment", "frustration", "boredom", "anxiety",
        "intimidation", "helplessness", "envy", "regret", "hate", "bad", "sad",
        "embarrassed", "indifference",
    }
)


class HNLVoterModel:
    """A binary-opinion voter model on a hypergraph.

    ``nodes`` must be ``0 .. n - 1`` because hyperedges index into the opinion
    array. ``influence_weights`` and ``latencies`` have one entry per node;
    ``q`` is the non-linearity exponent; ``consensus_threshold`` is in
    ``[0.5, 1]``. ``random_seed`` seeds the private NumPy generator.
    """

    def __init__(
        self,
        nodes: np.ndarray,
        hyperedges: Sequence[Sequence[int]],
        influence_weights: np.ndarray,
        q: float,
        latencies: np.ndarray,
        consensus_threshold: float,
        random_seed: int | None = None,
        opinions: np.ndarray | None = None,
    ) -> None:
        self.nodes = np.asarray(nodes, dtype=int)
        self.hyperedges = [self._normalize_edge(edge) for edge in hyperedges]
        self.influence_weights = np.asarray(influence_weights, dtype=float)
        self.q = float(q)
        self.latencies = np.asarray(latencies, dtype=int)
        self.consensus_threshold = float(consensus_threshold)
        self.random_seed = random_seed
        self._rng = np.random.default_rng(random_seed)

        self._validate_inputs()

        if opinions is None:
            self.opinions = self._rng.integers(0, 2, size=len(self.nodes), dtype=int)
        else:
            opinions_array = np.asarray(opinions, dtype=int)
            if opinions_array.shape != (len(self.nodes),):
                raise ValueError("opinions must have one entry per node")
            if not np.isin(opinions_array, (0, 1)).all():
                raise ValueError("opinions must be binary (0 or 1)")
            self.opinions = opinions_array.copy()

        self.last_change_time = np.zeros(len(self.nodes), dtype=int)
        self.time_step = 0
        self.history: list[dict[str, Any]] = []

    # ------------------------------------------------------------------
    # Validation
    # ------------------------------------------------------------------
    def _normalize_edge(self, edge: Sequence[int]) -> list[int]:
        if edge is None:
            raise ValueError("hyperedges must not contain None")
        values = [int(node) for node in edge]
        if not values:
            raise ValueError("hyperedges must not be empty")
        # Duplicate nodes inside one edge would count their influence twice.
        return list(dict.fromkeys(values))

    def _validate_inputs(self) -> None:
        node_count = len(self.nodes)
        if node_count == 0:
            raise ValueError("at least one node is required")
        if not np.array_equal(self.nodes, np.arange(node_count)):
            raise ValueError("nodes must be the consecutive integers 0 .. n-1")
        if self.influence_weights.shape != (node_count,):
            raise ValueError("influence_weights must have one entry per node")
        if self.latencies.shape != (node_count,):
            raise ValueError("latencies must have one entry per node")
        if not np.isfinite(self.influence_weights).all() or (self.influence_weights < 0).any():
            raise ValueError("influence_weights must be finite and non-negative")
        if not np.isfinite(self.q) or self.q < 0:
            raise ValueError("q must be a finite, non-negative number")
        if not 0.5 <= self.consensus_threshold <= 1.0:
            raise ValueError("consensus_threshold must be in [0.5, 1]")
        if (self.latencies < 1).any():
            raise ValueError("latencies must be at least 1")

        node_set = set(self.nodes.tolist())
        for edge in self.hyperedges:
            if any(node not in node_set for node in edge):
                raise ValueError(f"hyperedge contains unknown node: {edge}")
        if not self.hyperedges:
            raise ValueError("at least one hyperedge is required")

    # ------------------------------------------------------------------
    # Simulation
    # ------------------------------------------------------------------
    def compute_influence_scores(self, edge: Sequence[int]) -> tuple[float, float]:
        """Returns the weighted influence ``(S_0, S_1)`` inside ``edge``."""
        indices = np.asarray(edge, dtype=int)
        weights = self.influence_weights[indices]
        opinions = self.opinions[indices]
        score_zero = float(weights[opinions == 0].sum())
        score_one = float(weights[opinions == 1].sum())
        return score_zero, score_one

    def update_opinions(self) -> int:
        """Applies one synchronous update and returns the number of changes."""
        old_opinions = self.opinions
        new_opinions = old_opinions.copy()
        for edge in self.hyperedges:
            score_zero, score_one = self.compute_influence_scores(edge)
            score_zero = score_zero ** self.q
            score_one = score_one ** self.q
            total = score_zero + score_one
            probability_one = score_one / total if total > 0 else 0.5
            for node in edge:
                if self.time_step - self.last_change_time[node] < self.latencies[node]:
                    continue
                updated = 1 if self._rng.random() < probability_one else 0
                if updated != old_opinions[node]:
                    new_opinions[node] = updated
                    self.last_change_time[node] = self.time_step
        changed = int(np.count_nonzero(new_opinions != old_opinions))
        self.opinions = new_opinions
        return changed

    def metrics(self) -> dict[str, float]:
        """Returns diversity, cascade size, and mean opinion for the current state."""
        zeros = int(np.count_nonzero(self.opinions == 0))
        ones = len(self.opinions) - zeros
        diversity = 1.0 - max(zeros, ones) / len(self.nodes)
        if self.history:
            previous = np.asarray(self.history[-1]["opinions"], dtype=int)
            cascade_size = float(np.count_nonzero(previous != self.opinions) / len(self.nodes))
        else:
            cascade_size = 0.0
        return {
            "diversity": float(diversity),
            "cascade_size": cascade_size,
            "mean_opinion": float(np.mean(self.opinions)),
        }

    def check_consensus(self) -> bool:
        """Returns ``True`` when the largest opinion share meets the threshold."""
        share_one = float(np.mean(self.opinions))
        return share_one >= self.consensus_threshold or share_one <= 1.0 - self.consensus_threshold

    def reset(self) -> None:
        """Clears the history and latency memory while keeping current opinions."""
        self.history = []
        self.time_step = 0
        self.last_change_time = np.zeros(len(self.nodes), dtype=int)

    def run(
        self,
        max_steps: int = 100,
        stop_on_consensus: bool = True,
        reset: bool = True,
    ) -> list[dict[str, Any]]:
        """Runs the model and returns the history (one entry per time step).

        When ``reset`` is true (the default) the history and latency memory are
        cleared first; the current opinions are used as the initial state.
        """
        if max_steps < 0:
            raise ValueError("max_steps must not be negative")
        if reset:
            self.reset()
        else:
            self.history = []
        for step in range(max_steps + 1):
            values = self.metrics()
            entry = {
                "time_step": step,
                "diversity": values["diversity"],
                "cascade_size": values["cascade_size"],
                "mean_opinion": values["mean_opinion"],
                "opinions": self.opinions.tolist(),
            }
            self.history.append(entry)
            if stop_on_consensus and self.check_consensus():
                LOGGER.info("Consensus reached at step %d", step)
                break
            if step == max_steps:
                break
            self.time_step = step + 1
            self.update_opinions()
        return self.history

    # ------------------------------------------------------------------
    # Persistence and plotting
    # ------------------------------------------------------------------
    def to_dict(self) -> dict[str, Any]:
        """Returns a JSON-serializable snapshot of the model."""
        return {
            "version": 2,
            "nodes": self.nodes.tolist(),
            "hyperedges": self.hyperedges,
            "influence_weights": self.influence_weights.tolist(),
            "q": self.q,
            "latencies": self.latencies.tolist(),
            "consensus_threshold": self.consensus_threshold,
            "random_seed": self.random_seed,
            "opinions": self.opinions.tolist(),
            "last_change_time": self.last_change_time.tolist(),
            "time_step": self.time_step,
            "history": self.history,
        }

    def save(self, path: str | Path) -> Path:
        """Writes the model snapshot to ``path`` as JSON."""
        output = Path(path)
        output.parent.mkdir(parents=True, exist_ok=True)
        output.write_text(json.dumps(self.to_dict(), indent=2), encoding="utf-8")
        LOGGER.info("Saved model to %s", output)
        return output

    @classmethod
    def load(cls, path: str | Path, random_seed: int | None = None) -> HNLVoterModel:
        """Loads a snapshot previously written by :meth:`save`."""
        payload = json.loads(Path(path).read_text(encoding="utf-8"))
        model = cls(
            nodes=np.asarray(payload["nodes"], dtype=int),
            hyperedges=payload["hyperedges"],
            influence_weights=np.asarray(payload["influence_weights"], dtype=float),
            q=payload["q"],
            latencies=np.asarray(payload["latencies"], dtype=int),
            consensus_threshold=payload["consensus_threshold"],
            random_seed=random_seed if random_seed is not None else payload.get("random_seed"),
            opinions=np.asarray(payload["opinions"], dtype=int),
        )
        model.last_change_time = np.asarray(payload.get("last_change_time", []), dtype=int)
        model.time_step = int(payload.get("time_step", 0))
        model.history = list(payload.get("history", []))
        return model

    def plot_metrics(
        self,
        title: str = "HNL Voter Model Dynamics",
        save_path: str | Path | None = None,
        show: bool = True,
    ) -> Path | None:
        """Plots diversity, cascade size, and mean opinion over time."""
        if not self.history:
            raise ValueError("run the simulation before plotting")
        import matplotlib.pyplot as plt  # imported lazily: not needed for simulation

        steps = [entry["time_step"] for entry in self.history]
        figure, axes = plt.subplots(1, 3, figsize=(15, 4.5))
        figure.suptitle(title, fontsize=16)
        panels = (
            ("diversity", "Opinion Diversity", "Diversity"),
            ("cascade_size", "Cascade Size", "Share of nodes that changed"),
            ("mean_opinion", "Mean Opinion", "Share with opinion 1"),
        )
        for axis, (key, panel_title, ylabel) in zip(axes, panels):
            axis.plot(steps, [entry.get(key, 0.0) for entry in self.history], marker="o", markersize=3)
            axis.set_title(panel_title)
            axis.set_xlabel("Time step")
            axis.set_ylabel(ylabel)
            axis.grid(alpha=0.3)
        figure.tight_layout(rect=(0, 0.03, 1, 0.95))

        output = None
        if save_path is not None:
            output = Path(save_path)
            output.parent.mkdir(parents=True, exist_ok=True)
            figure.savefig(output, dpi=150)
        if show:
            plt.show()
        else:
            plt.close(figure)
        return output

    # ------------------------------------------------------------------
    # Dataset loading
    # ------------------------------------------------------------------
    @classmethod
    def from_dataset(
        cls,
        dataset_path: str | Path,
        q: float = 1.5,
        consensus_threshold: float = 0.8,
        random_seed: int | None = 42,
        *,
        user_column: str = "User",
        sentiment_column: str = "Sentiment",
        hashtags_column: str = "Hashtags",
        retweets_column: str = "Retweets",
        likes_column: str = "Likes",
        timestamp_column: str = "Timestamp",
    ) -> HNLVoterModel:
        """Builds a model from the sentiment CSV used in the notebooks.

        Users become nodes, hashtags become hyperedges, and each user's most
        recent sentiment becomes their initial opinion.  Retweets and likes are
        averaged into an influence weight.
        """
        try:
            import pandas as pd
        except ImportError as exception:  # pragma: no cover - dependency hint
            raise ImportError("pandas is required for from_dataset()") from exception

        frame = pd.read_csv(dataset_path)
        frame.columns = [str(column).strip() for column in frame.columns]
        required = [user_column, sentiment_column, hashtags_column]
        missing = [column for column in required if column not in frame.columns]
        if missing:
            raise ValueError(f"dataset is missing required columns: {missing}")

        for column in (user_column, sentiment_column, hashtags_column):
            frame[column] = frame[column].astype("string").str.strip()
        frame = frame.dropna(subset=[user_column, sentiment_column])
        frame = frame[frame[user_column].str.len() > 0]
        frame = frame[frame[sentiment_column].str.len() > 0]
        if frame.empty:
            raise ValueError("dataset has no rows with a user and a sentiment")

        for column in (retweets_column, likes_column):
            if column in frame.columns:
                frame[column] = pd.to_numeric(frame[column], errors="coerce").fillna(0.0)
            else:
                frame[column] = 0.0

        users = list(dict.fromkeys(frame[user_column].tolist()))
        user_to_index = {user: index for index, user in enumerate(users)}
        nodes = np.arange(len(users))

        grouped = frame.groupby(user_column, sort=False)[[retweets_column, likes_column]].mean()
        influence_weights = np.array(
            [float(grouped.loc[user].mean()) + 1.0 for user in users],
            dtype=float,
        )

        hashtag_to_users: dict[str, list[int]] = defaultdict(list)
        for user, hashtags in zip(frame[user_column], frame[hashtags_column]):
            if not isinstance(hashtags, str):
                continue
            index = user_to_index[user]
            for tag in hashtags.replace(",", " ").split():
                cleaned = tag.strip().lstrip("#")
                if cleaned:
                    hashtag_to_users[cleaned].append(index)
        hyperedges = [
            list(dict.fromkeys(indices))
            for indices in hashtag_to_users.values()
            if len(set(indices)) >= 2
        ]
        if not hyperedges:
            raise ValueError(
                "no hyperedges with at least two users were found; "
                f"check the {hashtags_column!r} column"
            )

        counts = frame[user_column].value_counts()
        latencies = np.array(
            [max(1, round(10.0 / float(counts.get(user, 1)))) for user in users],
            dtype=int,
        )

        if timestamp_column in frame.columns:
            timestamps = pd.to_datetime(frame[timestamp_column], errors="coerce")
            ordered = frame.assign(_timestamp=timestamps).sort_values("_timestamp", kind="stable")
            if ordered["_timestamp"].isna().all():
                ordered = frame
        else:
            ordered = frame
        latest_sentiment = ordered.groupby(user_column, sort=False)[sentiment_column].last()

        def polarity(sentiment: str) -> int:
            normalized = sentiment.strip().lower()
            if normalized in POSITIVE_SENTIMENTS:
                return 1
            if normalized in NEGATIVE_SENTIMENTS:
                return 0
            return 1

        opinions = np.array(
            [polarity(str(latest_sentiment.get(user, "neutral"))) for user in users],
            dtype=int,
        )

        model = cls(
            nodes=nodes,
            hyperedges=hyperedges,
            influence_weights=influence_weights,
            q=q,
            latencies=latencies,
            consensus_threshold=consensus_threshold,
            random_seed=random_seed,
            opinions=opinions,
        )
        LOGGER.info(
            "Built model from %s: %d users, %d hyperedges", dataset_path, len(users), len(hyperedges)
        )
        return model


def generate_random_hypergraph(
    num_nodes: int,
    num_edges: int,
    min_edge_size: int = 2,
    max_edge_size: int = 10,
    random_seed: int | None = None,
) -> tuple[np.ndarray, list[list[int]]]:
    """Generates a random hypergraph with the requested number of edges."""
    if num_nodes < 1:
        raise ValueError("num_nodes must be positive")
    if num_edges < 1:
        raise ValueError("num_edges must be positive")
    if not 1 <= min_edge_size <= max_edge_size <= num_nodes:
        raise ValueError("edge sizes must satisfy 1 <= min <= max <= num_nodes")
    rng = np.random.default_rng(random_seed)
    edges = []
    for _ in range(num_edges):
        size = int(rng.integers(min_edge_size, max_edge_size + 1))
        edges.append(rng.choice(num_nodes, size=size, replace=False).astype(int).tolist())
    return np.arange(num_nodes), edges


def _build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(
        description="Run the Hybrid Non-linear Latency voter model.",
        formatter_class=argparse.ArgumentDefaultsHelpFormatter,
    )
    source = parser.add_mutually_exclusive_group()
    source.add_argument("--dataset", type=Path, help="sentiment CSV to build the model from")
    source.add_argument("--load", type=Path, help="previously saved model JSON")
    parser.add_argument("--nodes", type=int, default=100, help="nodes in the random hypergraph")
    parser.add_argument("--edges", type=int, default=20, help="hyperedges in the random graph")
    parser.add_argument("--min-edge-size", type=int, default=5)
    parser.add_argument("--max-edge-size", type=int, default=15)
    parser.add_argument("--q", type=float, default=1.5, help="non-linearity exponent")
    parser.add_argument("--threshold", type=float, default=0.8, help="consensus threshold")
    parser.add_argument("--seed", type=int, default=42, help="random seed")
    parser.add_argument("--steps", type=int, default=100, help="maximum number of steps")
    parser.add_argument("--save", type=Path, help="write the final model to this JSON file")
    parser.add_argument("--plot", type=Path, help="write the metrics plot to this PNG file")
    parser.add_argument(
        "--keep-running",
        action="store_true",
        help="do not stop early when consensus is reached",
    )
    parser.add_argument("--quiet", action="store_true", help="only print the summary")
    return parser


def main(argv: Sequence[str] | None = None) -> int:
    """Command-line entry point."""
    args = _build_parser().parse_args(argv)
    logging.basicConfig(
        level=logging.WARNING if args.quiet else logging.INFO,
        format="%(levelname)s: %(message)s",
    )

    if args.load is not None:
        model = HNLVoterModel.load(args.load, random_seed=args.seed)
    elif args.dataset is not None:
        model = HNLVoterModel.from_dataset(
            args.dataset,
            q=args.q,
            consensus_threshold=args.threshold,
            random_seed=args.seed,
        )
    else:
        nodes, hyperedges = generate_random_hypergraph(
            args.nodes,
            args.edges,
            args.min_edge_size,
            args.max_edge_size,
            random_seed=args.seed,
        )
        rng = np.random.default_rng(args.seed)
        latencies = np.clip(rng.normal(3.0, 1.0, size=len(nodes)), 1, None).astype(int)
        model = HNLVoterModel(
            nodes=nodes,
            hyperedges=hyperedges,
            influence_weights=np.ones(len(nodes)),
            q=args.q,
            latencies=latencies,
            consensus_threshold=args.threshold,
            random_seed=args.seed,
        )

    history = model.run(args.steps, stop_on_consensus=not args.keep_running)
    last = history[-1]
    print(
        f"steps={last['time_step']} nodes={len(model.nodes)} "
        f"hyperedges={len(model.hyperedges)} diversity={last['diversity']:.3f} "
        f"mean_opinion={last['mean_opinion']:.3f} consensus={model.check_consensus()}"
    )
    if args.save is not None:
        model.save(args.save)
        print(f"model written to {args.save}")
    if args.plot is not None:
        model.plot_metrics(save_path=args.plot, show=False)
        print(f"plot written to {args.plot}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
