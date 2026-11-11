import sys
from pathlib import Path

import numpy as np
import pandas as pd
import pytest

sys.path.insert(0, str(Path(__file__).resolve().parents[1] / "hnl_voter_model"))

from hnl_voter_model import HNLVoterModel, generate_random_hypergraph


def small_model(**overrides):
    parameters = {
        "nodes": np.arange(6),
        "hyperedges": [[0, 1, 2], [3, 4, 5]],
        "influence_weights": np.ones(6),
        "q": 1.5,
        "latencies": np.ones(6, dtype=int),
        "consensus_threshold": 0.8,
        "random_seed": 7,
    }
    parameters.update(overrides)
    return HNLVoterModel(**parameters)


def test_run_records_valid_history():
    model = small_model()
    history = model.run(max_steps=10)
    assert 1 <= len(history) <= 11
    assert history[0]["time_step"] == 0
    assert history[0]["cascade_size"] == 0.0
    for entry in history:
        assert 0.0 <= entry["diversity"] <= 0.5
        assert 0.0 <= entry["mean_opinion"] <= 1.0
        assert len(entry["opinions"]) == 6
        assert set(entry["opinions"]) <= {0, 1}


def test_consensus_stops_immediately():
    model = small_model(opinions=np.array([0, 0, 0, 0, 0, 1]))
    history = model.run(max_steps=10)
    assert len(history) == 1
    assert model.check_consensus()


def test_keep_running_records_total_steps():
    model = small_model(opinions=np.array([0, 0, 0, 0, 0, 1]))
    history = model.run(max_steps=4, stop_on_consensus=False)
    assert len(history) == 5
    assert model.time_step == 4


def test_update_opinions_keeps_binary_state():
    model = small_model()
    before = model.opinions.copy()
    changed = model.update_opinions()
    assert changed >= 0
    assert set(model.opinions.tolist()) <= {0, 1}
    assert model.opinions.shape == before.shape


def test_save_and_load_round_trip(tmp_path):
    model = small_model()
    model.run(max_steps=5)
    target = tmp_path / "model.json"
    model.save(target)
    loaded = HNLVoterModel.load(target)
    assert np.array_equal(loaded.opinions, model.opinions)
    assert loaded.q == model.q
    assert loaded.hyperedges == model.hyperedges
    assert loaded.history == model.history


def test_generate_random_hypergraph():
    nodes, edges = generate_random_hypergraph(20, 8, 2, 5, random_seed=1)
    assert np.array_equal(nodes, np.arange(20))
    assert len(edges) == 8
    for edge in edges:
        assert 2 <= len(edge) <= 5
        assert len(set(edge)) == len(edge)
        assert all(0 <= node < 20 for node in edge)


def test_from_dataset_builds_nodes_edges_and_opinions(tmp_path):
    dataset = tmp_path / "sentiment.csv"
    pd.DataFrame(
        {
            "Text": ["a", "b", "c", "d"],
            "Sentiment": [" Positive ", "Negative", "Happy", "Sad"],
            "Timestamp": [
                "2024-01-01 10:00:00",
                "2024-01-01 11:00:00",
                "2024-01-01 12:00:00",
                "2024-01-01 13:00:00",
            ],
            "User": ["alice", "bob", "alice", "carol"],
            "Hashtags": ["#science #news", "#news #science", "#science", "#other #science"],
            "Retweets": [1, 2, 3, 4],
            "Likes": [10, 20, 30, 40],
        }
    ).to_csv(dataset, index=False)

    model = HNLVoterModel.from_dataset(dataset, random_seed=0)
    assert len(model.nodes) == 3
    assert len(model.hyperedges) == 2
    assert np.all(model.influence_weights >= 0.0)
    assert set(model.opinions.tolist()) <= {0, 1}
    # alice's latest sentiment is Happy (positive), carol's is Sad (negative).
    assert model.opinions[0] == 1
    assert model.opinions[2] == 0


def test_plot_metrics_writes_png(tmp_path):
    model = small_model()
    model.run(max_steps=3)
    output = tmp_path / "plot.png"
    model.plot_metrics(save_path=output, show=False)
    assert output.is_file()
    assert output.stat().st_size > 0


@pytest.mark.parametrize(
    "overrides",
    [
        {"nodes": np.array([1, 2])},
        {"influence_weights": np.ones(5)},
        {"latencies": np.zeros(6, dtype=int)},
        {"q": -1},
        {"consensus_threshold": 0.4},
        {"hyperedges": []},
        {"hyperedges": [[0, 99]]},
        {"opinions": np.array([0, 1])},
    ],
)
def test_invalid_inputs_are_rejected(overrides):
    with pytest.raises(ValueError):
        small_model(**overrides)
