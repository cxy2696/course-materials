import sys
from pathlib import Path

import pytest

sys.path.insert(0, str(Path(__file__).resolve().parents[1] / "pythonCoauthorship"))

from coauthorship import (  # noqa: E402
    build_graph,
    component_size_counts,
    degree_counts,
    largest_component,
    parse_record,
)


def test_parse_four_field_record():
    year, authors = parse_record(
        "2000    17  AAAI     Achlioptas & Gomes & Kautz & Selman, A title"
    )
    assert year == 2000
    assert authors == ["Achlioptas", "Gomes", "Kautz", "Selman"]


def test_parse_three_field_record():
    year, authors = parse_record("1993  AAPT  Swartz, Used Math, second edition")
    assert year == 1993
    assert authors == ["Swartz"]


def test_parse_rejects_malformed_lines():
    assert parse_record("") is None
    assert parse_record("not a record") is None
    assert parse_record("2000 only-two-fields") is None


def test_graph_keeps_single_authors_and_skips_self_edges():
    records = [(2000, ["Alice", "Bob"]), (2001, ["Carol"]), (2002, ["Alice", "Alice"])]
    graph = build_graph(records)
    assert set(graph.nodes) == {"Alice", "Bob", "Carol"}
    assert graph.number_of_edges() == 1
    assert graph.degree["Carol"] == 0
    assert degree_counts(graph) == {1: 2, 0: 1}
    assert component_size_counts(graph) == {2: 1, 1: 1}
    assert largest_component(graph).number_of_nodes() == 2


def test_empty_graph_is_rejected():
    with pytest.raises(ValueError):
        largest_component(build_graph([]))
