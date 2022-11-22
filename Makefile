# Project

srcdir = comoresolve


# Build

.PHONY: build
build:
	poetry build


# Format

.PHONY: fmt fmt-isort fmt-autopep8
fmt: fmt-isort fmt-autopep8

fmt-isort:
	poetry run isort --only-modified $(srcdir)

fmt-autopep8:
	poetry run autopep8 --in-place $(srcdir)


# Lint

.PHONY: lint lint-poetry lint-isort lint-autopep8 lint-flake8 lint-mypy lint-bandit
lint: lint-poetry lint-isort lint-autopep8 lint-flake8 lint-mypy lint-bandit

lint-poetry:
	poetry check

lint-isort:
	poetry run isort --check --diff $(srcdir)

lint-autopep8:
	poetry run autopep8 --diff $(srcdir)

lint-flake8:
	poetry run flake8 --show-source $(srcdir)

lint-mypy:
	poetry run mypy --show-error-context --pretty $(srcdir)

lint-bandit:
	poetry run bandit --silent --recursive $(srcdir)


# Clean

.PHONY: clean
clean:
	find $(srcdir) -name '__pycache__' -exec rm -rf {} +
	find $(srcdir) -type d -empty -delete
	rm -rf poetry.lock dist .mypy_cache
