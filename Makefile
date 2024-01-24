#!/usr/bin/env make
include ./make/Makehelp
include ./make/bootstrap.mk

## Check required bins
check: _header
	$(foreach bin,$(REQUIRED_BINS),\
		$(if $(shell command -v $(bin) 2> /dev/null),$(info ✅ Found $(bin).),$(error ❌ Please install $(bin).)))
.PHONY: check

# Define a variable for Python and notebook files.
PYTHON_FILES=.

## Installs Formatter and Linter
install_formatter:
	@pip3 install ruff==0.1.3 black==23.10.1
.PHONY: install_formatter

## Checks for linting and formatting
lint: install_formatter check
	@echo "Running Formatter..."
	@black . --check
	@echo "Running Linter..."
	@ruff check .
.PHONY: lint

## Fixes linting and formatting issues
format: install_formatter check
	@echo "Fixing Format..."
	@black $(PYTHON_FILES)
	@echo "Fixing Linting..."
	ruff --select I --fix $(PYTHON_FILES)
.PHONY: format


## Create header
_header:
	@ printf "${GREEN}$$HEADER\n${RESET}"