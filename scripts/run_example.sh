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

if [[ ! -f "$ROOT_DIR/examples/${EXAMPLE}.py" ]]; then
  echo "Example not found: examples/${EXAMPLE}.py"
  exit 1
fi

PYTHONPATH="$ROOT_DIR" exec "$ROOT_DIR/.venv/bin/python" "$ROOT_DIR/examples/${EXAMPLE}.py"
