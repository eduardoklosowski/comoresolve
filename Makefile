# Project

SRC_DIR := ./src
VENV_DIR := ./venv


# Build

.PHONY: build

build:
	poetry build


# Init

.PHONY: init

init:
	poetry install --sync


# Format

.PHONY: fmt

fmt:
	poetry run isort --only-modified $(SRC_DIR)
	poetry run autopep8 --in-place $(SRC_DIR)


# Lint

.PHONY: lint lint-poetry lint-isort lint-autopep8 lint-flake8 lint-mypy lint-bandit

lint: lint-poetry lint-isort lint-autopep8 lint-flake8 lint-mypy lint-bandit

lint-poetry:
	poetry check

lint-isort:
	poetry run isort --check --diff $(SRC_DIR)

lint-autopep8:
	poetry run autopep8 --diff $(SRC_DIR)

lint-flake8:
	poetry run flake8 --show-source $(SRC_DIR)

lint-mypy:
	poetry run mypy --show-error-context --pretty $(SRC_DIR)

lint-bandit:
	poetry run bandit --silent --recursive $(SRC_DIR)


# Test

.PHONY: test

test:


# Clean

.PHONY: clean clean-build clean-pycache clean-python-tools

clean: clean-build clean-pycache clean-python-tools

clean-build:
	rm -rf dist

clean-pycache:
	find $(SRC_DIR) -name '__pycache__' -exec rm -rf {} +
	find $(SRC_DIR) -type d -empty -delete

clean-python-tools:
	rm -rf .mypy_cache

clean-lock:
	rm -rf poetry.lock

dist-clean: clean clean-lock
	rm -rf $(VENV_DIR)
