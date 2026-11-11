#!/usr/bin/env bash
# Compile the main sources and run the dependency-free self-tests.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OUT="$ROOT/out"
TEST_OUT="$ROOT/out-test"

"$ROOT/build.sh"
rm -rf "$TEST_OUT"
mkdir -p "$TEST_OUT"
javac --release 17 -Xlint:all -cp "$OUT" -d "$TEST_OUT" \
    "$ROOT/test/coursework/JavaSelfTest.java"
java -cp "$OUT:$TEST_OUT" coursework.JavaSelfTest
