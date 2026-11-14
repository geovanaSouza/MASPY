# VENV: virtual environment path (default: .venv)
VENV ?= .venv
# PYTHON: Python interpreter used by setup (default: $(VENV)/bin/python)
PYTHON ?= $(VENV)/bin/python

.PHONY: setup run list-examples help

setup: ## Create the virtual environment and install dependencies
	uv venv $(VENV) --python 3.12
	uv pip install --python $(PYTHON) numpy pandas maspy-ml

run: ## Run an example: make run EXAMPLE=<name>
	./scripts/run_example.sh $(EXAMPLE)

list-examples: ## List runnable example names
	@echo "Available examples:"
	@find examples -name '*.py' | sed 's|^examples/||; s|\.py$$||' | sort | while read -r name; do echo "  $$name"; done

help: ## Show this help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z0-9_.-]+:.*?## / {printf "  %-16s %s\n", $$1, $$2}' $(MAKEFILE_LIST)
	@echo ""
	@echo "Options (override on the command line): VENV, PYTHON, EXAMPLE"
