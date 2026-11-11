#!/usr/bin/env python3
"""Variant of the coauthorship homework that uses an explicit BFS queue.

The analysis code lives in ``../pythonCoauthorship/coauthorship.py``; this
entry point selects the manual breadth-first-search implementation for
Problems 3 and 4 so the two approaches can be compared.

Usage (from this folder)::

    python custom_bfs.py
    python custom_bfs.py --data ps1data.txt --output-dir outputs
"""

import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1] / "pythonCoauthorship"))

from coauthorship import main  # noqa: E402  (path is set up above)

if __name__ == "__main__":
    main(manual_bfs=True)
