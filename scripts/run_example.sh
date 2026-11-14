#!/usr/bin/env bash
set -euo pipefail

# Run a MASPY example by name.
# Usage: ./scripts/run_example.sh ex-hello-world

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

if [[ ! -x "$ROOT_DIR/.venv/bin/python" ]]; then
  echo "Missing .venv. Create it first:"
  echo "  make setup"
  exit 1
fi

EXAMPLE="${1:-}"
if [[ -z "$EXAMPLE" ]]; then
  echo "Usage: ./scripts/run_example.sh <example_name_without_.py>"
  echo "Example: ./scripts/run_example.sh ex-hello-world"
  exit 1
fi

# Examples live in category subfolders (Basic/, Intermediate/, Advanced/, Learning/, ...).
# Accept either a bare name (ex-hello-world) or a relative path (Basic/ex-hello-world).
if [[ -f "$ROOT_DIR/examples/${EXAMPLE}.py" ]]; then
  EX_FILE="$ROOT_DIR/examples/${EXAMPLE}.py"
else
  EX_FILE="$(find "$ROOT_DIR/examples" -type f -name "${EXAMPLE}.py" -print -quit)"
fi

if [[ -z "$EX_FILE" ]]; then
  echo "Example not found: ${EXAMPLE}.py (searched examples/ recursively)"
  echo "Run 'make list-examples' to see the available names."
  exit 1
fi

PYTHONPATH="$ROOT_DIR" exec "$ROOT_DIR/.venv/bin/python" "$EX_FILE"
