#!/usr/bin/env bash
# Compile every Java source into java/out.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OUT="$ROOT/out"

rm -rf "$OUT"
mkdir -p "$OUT"

sources=()
while IFS= read -r file; do
    sources+=("$file")
done < <(find "$ROOT/src" -name '*.java' -print | sort)

if [[ ${#sources[@]} -eq 0 ]]; then
    echo "No Java sources found under $ROOT/src" >&2
    exit 1
fi

javac --release 17 -Xlint:all -d "$OUT" "${sources[@]}"
echo "Compiled ${#sources[@]} Java files into $OUT"
