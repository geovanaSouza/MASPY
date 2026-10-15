VENV ?= .venv
PYTHON ?= $(VENV)/bin/python

.PHONY: setup run list-examples

setup:
	uv venv $(VENV) --python 3.12
	uv pip install --python $(PYTHON) numpy pandas maspy-ml

run:
	./scripts/run_example.sh $(EXAMPLE)

list-examples:
	@echo "Available examples:"
	@for f in examples/*.py; do echo "  $$(basename "$$f" .py)"; done
