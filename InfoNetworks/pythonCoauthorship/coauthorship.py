"""Coauthorship-network analysis for the CS 6850 homework.

The input file is a whitespace-delimited bibliography::

    1996    3  3CONLINE     Shene, A Comparative Study of Linked List Sorting Algorithms
    2000   17  AAAI         Achlioptas & Gomes & Kautz & Selman, Generating ...
    2000   17  AAAI         Ben-Eliyahu-Zohary, A Demand-Driven Algorithm ...

Columns are ``year``, ``citation count``, ``venue``, then the author list up to
the first comma, followed by the paper title.  Authors are separated by ``&``.
Earlier versions split the whole line on commas, which mixed the year/venue
fields into the name of every single-author paper; this module parses the
fields explicitly.

Running the script writes ``hw1solution.txt`` and four PDF plots (degree
distribution, component sizes, distances from a root, and average potential
parents per BFS level) to the output directory.
"""

from __future__ import annotations

import argparse
import math
from collections import Counter, deque
from pathlib import Path

import matplotlib

matplotlib.use("Agg")  # headless-safe; the script only writes PDFs
import matplotlib.pyplot as plt
import networkx as nx

YEAR_MIN = 1985
YEAR_MAX = 2005
DEFAULT_ROOT = "Gries"
DEFAULT_NETID = "xc535"


def parse_record(line: str) -> tuple[int, list[str]] | None:
    """Parse one bibliography line into (year, authors)."""
    head, _, _title = line.partition(",")
    fields = head.split(None, 3)
    if len(fields) < 4:
        return None
    try:
        year = int(fields[0])
    except ValueError:
        return None
    authors = [name.strip() for name in fields[3].split("&") if name.strip()]
    if not authors:
        return None
    return year, authors


def load_records(path: Path) -> list[tuple[int, list[str]]]:
    """Load records inside the assignment's year window."""
    records = []
    with path.open(encoding="utf-8", errors="replace") as handle:
        for line in handle:
            record = parse_record(line)
            if record is None:
                continue
            year, authors = record
            if YEAR_MIN <= year <= YEAR_MAX:
                records.append((year, authors))
    return records


def build_graph(records: list[tuple[int, list[str]]]) -> nx.Graph:
    """Build an undirected coauthorship graph."""
    graph = nx.Graph()
    for _year, authors in records:
        graph.add_nodes_from(authors)
        for i, first in enumerate(authors):
            for second in authors[i + 1 :]:
                if first != second:
                    graph.add_edge(first, second)
    return graph


def largest_component(graph: nx.Graph) -> nx.Graph:
    """Return a copy of the largest connected component."""
    if graph.number_of_nodes() == 0:
        raise ValueError("The coauthorship graph is empty")
    component = max(nx.connected_components(graph), key=len)
    return graph.subgraph(component).copy()


def bfs_levels_networkx(graph: nx.Graph, root: str) -> dict[str, int]:
    """Distances from ``root`` using NetworkX's breadth-first search."""
    return dict(nx.single_source_shortest_path_length(graph, root))


def bfs_levels_manual(graph: nx.Graph, root: str) -> dict[str, int]:
    """Distances from ``root`` using an explicit FIFO queue (course exercise)."""
    levels = {root: 0}
    queue = deque([root])
    while queue:
        node = queue.popleft()
        for neighbor in graph.neighbors(node):
            if neighbor not in levels:
                levels[neighbor] = levels[node] + 1
                queue.append(neighbor)
    return levels


def degree_counts(graph: nx.Graph) -> Counter[int]:
    """Count how many nodes have each degree."""
    return Counter(degree for _node, degree in graph.degree())


def component_size_counts(graph: nx.Graph) -> Counter[int]:
    """Count how many connected components have each size."""
    return Counter(len(component) for component in nx.connected_components(graph))


def potential_parents(graph: nx.Graph, levels: dict[str, int]) -> dict[int, float]:
    """Average number of level-``l-1`` neighbours for nodes at each level."""
    result: dict[int, float] = {}
    for level in range(1, max(levels.values()) + 1):
        nodes = [node for node, value in levels.items() if value == level]
        if not nodes:
            continue
        total = sum(
            sum(1 for neighbor in graph.neighbors(node) if levels.get(neighbor) == level - 1)
            for node in nodes
        )
        result[level] = total / len(nodes)
    return result


def _save_degree_plot(counts: Counter[int], path: Path) -> None:
    plt.figure()
    points = [(math.log(degree), math.log(count)) for degree, count in counts.items() if degree > 0]
    plt.scatter([x for x, _ in points], [y for _, y in points])
    plt.xlabel("log(Degree)")
    plt.ylabel("log(Count)")
    plt.title("Degree Distribution")
    plt.savefig(path, bbox_inches="tight")
    plt.close()


def _save_component_plot(counts: Counter[int], max_size: int, path: Path) -> None:
    plt.figure()
    points = [
        (math.log(size), math.log(count))
        for size, count in counts.items()
        if 1 <= size <= max_size and count > 0
    ]
    plt.scatter([x for x, _ in points], [y for _, y in points])
    plt.xlabel("log(Component Size)")
    plt.ylabel("log(Number of Components)")
    plt.title("Component Sizes Distribution")
    plt.savefig(path, bbox_inches="tight")
    plt.close()


def _save_distance_plot(levels: dict[str, int], root: str, path: Path) -> None:
    counts = Counter(distance for distance in levels.values() if distance > 0)
    plt.figure()
    plt.bar(counts.keys(), counts.values())
    plt.xlabel(f"Distance from {root}")
    plt.ylabel("Number of Nodes")
    plt.title(f"Distances from {root}")
    plt.savefig(path, bbox_inches="tight")
    plt.close()


def _save_parent_plot(parents: dict[int, float], path: Path) -> None:
    plt.figure()
    plt.bar(parents.keys(), parents.values())
    plt.xlabel("Level")
    plt.ylabel("Average Potential Parents")
    plt.title("Potential Parents per Level")
    plt.savefig(path, bbox_inches="tight")
    plt.close()


def analyse(
    data_path: Path,
    output_dir: Path,
    netid: str = DEFAULT_NETID,
    root: str = DEFAULT_ROOT,
    manual_bfs: bool = False,
) -> dict[str, object]:
    """Run all four homework problems and write the outputs.

    Returns a summary dictionary for tests or interactive use.
    """
    records = load_records(data_path)
    graph = build_graph(records)
    largest = largest_component(graph)
    if root not in largest:
        root = next(iter(largest))

    output_dir.mkdir(parents=True, exist_ok=True)
    solution_lines = [f"@ {netid}"]

    # Problem 1: degree distribution.
    counts = degree_counts(graph)
    solution_lines.extend(f"@ 1 {degree} {count}" for degree, count in sorted(counts.items()))
    _save_degree_plot(counts, output_dir / "plot1.pdf")

    # Problem 2: connected components.
    sizes = sorted((len(component) for component in nx.connected_components(graph)), reverse=True)
    largest_size = sizes[0]
    total_nodes = graph.number_of_nodes()
    solution_lines.append(f"@ 2 {largest_size} {total_nodes} {largest_size / total_nodes}")
    second_largest = sizes[1] if len(sizes) > 1 else largest_size
    size_counts = component_size_counts(graph)
    solution_lines.extend(
        f"@ 2 {size} {size_counts[size]}"
        for size in range(1, second_largest + 1)
        if size_counts.get(size)
    )
    _save_component_plot(size_counts, second_largest, output_dir / "plot2.pdf")

    # Problem 3: distances from the root in the largest component.
    levels = bfs_levels_manual(largest, root) if manual_bfs else bfs_levels_networkx(largest, root)
    solution_lines.extend(
        f"@ 3 {distance} {count}"
        for distance, count in sorted(Counter(levels.values()).items())
        if distance > 0
    )
    _save_distance_plot(levels, root, output_dir / "plot3.pdf")

    # Problem 4: average potential parents per BFS level.
    parents = potential_parents(largest, levels)
    solution_lines.extend(f"@ 4 {level} {avg}" for level, avg in sorted(parents.items()))
    _save_parent_plot(parents, output_dir / "plot4.pdf")

    (output_dir / "hw1solution.txt").write_text("\n".join(solution_lines) + "\n", encoding="utf-8")
    return {
        "records": len(records),
        "nodes": graph.number_of_nodes(),
        "edges": graph.number_of_edges(),
        "largest_component": largest_size,
        "root": root,
        "solution": str(output_dir / "hw1solution.txt"),
    }


def main(argv: list[str] | None = None, *, manual_bfs: bool = False) -> None:
    parser = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    parser.add_argument("--data", type=Path, default=Path("ps1data.txt"), help="bibliography file")
    parser.add_argument("--output-dir", type=Path, default=Path("."), help="where to write results")
    parser.add_argument("--netid", default=DEFAULT_NETID, help="identifier written in the solution file")
    parser.add_argument("--root", default=DEFAULT_ROOT, help="root author for problems 3 and 4")
    parser.add_argument(
        "--manual-bfs",
        action="store_true",
        default=manual_bfs,
        help="use the explicit queue implementation instead of NetworkX",
    )
    args = parser.parse_args(argv)

    summary = analyse(
        data_path=args.data,
        output_dir=args.output_dir,
        netid=args.netid,
        root=args.root,
        manual_bfs=args.manual_bfs,
    )
    print(
        f"Read {summary['records']} records, built a graph with "
        f"{summary['nodes']} nodes and {summary['edges']} edges; "
        f"largest component = {summary['largest_component']} nodes."
    )
    print(f"Wrote {summary['solution']} and plot1-4.pdf")


if __name__ == "__main__":
    main()
