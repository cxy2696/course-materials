#!/usr/bin/env bash
# Run the interactive program menu, or a specific top-level class.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [[ ! -d "$ROOT/out" ]]; then
    "$ROOT/build.sh"
fi

if [[ $# -eq 0 ]]; then
    exec java -cp "$ROOT/out" coursework.Coursework
fi
exec java -cp "$ROOT/out" "$@"
