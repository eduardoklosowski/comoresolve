# Project

SRC_DIR := src
TESTS_DIR := tests
VENV_DIR := .venv


# Build

.PHONY: build

build: $(VENV_DIR)
	$(VENV_DIR)/bin/python -m build


# Init

.PHONY: init

init $(VENV_DIR):
	[ -e $(VENV_DIR) ] || python3 -m venv $(VENV_DIR)
	$(VENV_DIR)/bin/pip install -U pip
	$(VENV_DIR)/bin/pip install build setuptools wheel
	$(VENV_DIR)/bin/pip install --editable . --group dev


# Format

.PHONY: fmt

fmt: $(VENV_DIR)
	$(VENV_DIR)/bin/ruff check --select I001 --fix $(SRC_DIR) $(TESTS_DIR)
	$(VENV_DIR)/bin/ruff format $(SRC_DIR) $(TESTS_DIR)


# Lint

.PHONY: lint lint-pyproject lint-ruff-format lint-ruff-check lint-mypy

lint: lint-pyproject lint-ruff-format lint-ruff-check lint-mypy

lint-pyproject: $(VENV_DIR)
	$(VENV_DIR)/bin/validate-pyproject pyproject.toml

lint-ruff-format: $(VENV_DIR)
	$(VENV_DIR)/bin/ruff format --diff $(SRC_DIR) $(TESTS_DIR)

lint-ruff-check: $(VENV_DIR)
	$(VENV_DIR)/bin/ruff check $(SRC_DIR) $(TESTS_DIR)

lint-mypy: $(VENV_DIR)
	$(VENV_DIR)/bin/mypy --show-error-context --pretty $(SRC_DIR) $(TESTS_DIR)


# Test

.PHONY: test test-pytest test-coverage-report

test: test-pytest

test-pytest .coverage: $(VENV_DIR)
	$(VENV_DIR)/bin/coverage run -m pytest $(TESTS_DIR)
	$(VENV_DIR)/bin/coverage report -m

test-coverage-report: .coverage
	$(VENV_DIR)/bin/coverage html


# Clean

.PHONY: clean clean-pycache clean-build clean-python-tools clean-lock dist-clean

clean: clean-pycache clean-build clean-python-tools

clean-pycache:
	find $(SRC_DIR) $(TESTS_DIR) -name '__pycache__' -exec rm -rf {} +
	find $(SRC_DIR) $(TESTS_DIR) -type d -empty -delete

clean-build:
	rm -rf build dist $(SRC_DIR)/*.egg-info

clean-python-tools:
	rm -rf .ruff_cache .mypy_cache .pytest_cache .coverage .coverage.* htmlcov

clean-lock:
	rm -rf pylock.toml

dist-clean: clean clean-lock
	rm -rf $(VENV_DIR)
