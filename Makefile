# Project

SRC_DIR := src
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
	$(VENV_DIR)/bin/isort --only-modified $(SRC_DIR)
	$(VENV_DIR)/bin/autopep8 --in-place $(SRC_DIR)


# Lint

.PHONY: lint lint-pyproject lint-isort lint-autopep8 lint-flake8 lint-mypy lint-bandit

lint: lint-pyproject lint-isort lint-autopep8 lint-flake8 lint-mypy lint-bandit

lint-pyproject: $(VENV_DIR)
	$(VENV_DIR)/bin/validate-pyproject pyproject.toml

lint-isort: $(VENV_DIR)
	$(VENV_DIR)/bin/isort --check --diff $(SRC_DIR)

lint-autopep8: $(VENV_DIR)
	$(VENV_DIR)/bin/autopep8 --diff $(SRC_DIR)

lint-flake8: $(VENV_DIR)
	$(VENV_DIR)/bin/flake8 --show-source $(SRC_DIR)

lint-mypy: $(VENV_DIR)
	$(VENV_DIR)/bin/mypy --show-error-context --pretty $(SRC_DIR)

lint-bandit: $(VENV_DIR)
	$(VENV_DIR)/bin/bandit --silent --recursive $(SRC_DIR)


# Test

.PHONY: test

test:


# Clean

.PHONY: clean clean-pycache clean-build clean-python-tools clean-lock dist-clean

clean: clean-pycache clean-build clean-python-tools

clean-pycache:
	find $(SRC_DIR) -name '__pycache__' -exec rm -rf {} +
	find $(SRC_DIR) -type d -empty -delete

clean-build:
	rm -rf build dist $(SRC_DIR)/*.egg-info

clean-python-tools:
	rm -rf .mypy_cache

clean-lock:
	rm -rf pylock.toml

dist-clean: clean clean-lock
	rm -rf $(VENV_DIR)
