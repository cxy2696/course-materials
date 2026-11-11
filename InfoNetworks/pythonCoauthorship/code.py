#!/usr/bin/env python3
"""Command-line entry point for the CS 6850 coauthorship analysis.

Usage (from this folder)::

    python code.py
    python code.py --data ps1data.txt --output-dir outputs
    python code.py --root Gries --netid xc535

See ``coauthorship.py`` for the implementation and the input format.
"""

from coauthorship import main

if __name__ == "__main__":
    main()
