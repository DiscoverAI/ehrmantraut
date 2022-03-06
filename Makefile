SHELL := bash
.ONESHELL:
.SHELLFLAGS := -eu -o pipefail -c
.DELETE_ON_ERROR:
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules
.DEFAULT_GOAL := help

define PRINT_HELP_PYSCRIPT
import re, sys

for line in sys.stdin:
	match = re.match(r'^([a-zA-Z_-]+):.*?## (.*)$$', line)
	if match:
		target, help = match.groups()
		print("%-20s %s" % (target, help))
endef
export PRINT_HELP_PYSCRIPT

.PHONY: help
help: ## Shows help for targets with help text
	@python -c "$$PRINT_HELP_PYSCRIPT" < $(MAKEFILE_LIST)

.PHONY: install
install: ## Installs all dependencies
	poetry install

.PHONY: requirements.txt
requirements.txt: ## Creates requirements.txt file
	poetry export -f requirements.txt --output requirements.txt


.PHONY: run
run: ## Starts the mlflow instance
	poetry run mlflow server --backend-store-uri ./mlflow --default-artifact-root $DATALAKE --host 0.0.0.0




