#!/usr/bin/env make

.DEFAULT_GOAL := help

# COLORS
GREEN  := $(shell tput -Txterm setaf 2)
YELLOW := $(shell tput -Txterm setaf 3)
WHITE  := $(shell tput -Txterm setaf 7)
RED    := $(shell tput -Txterm setaf 1)
CYAN   := $(shell tput -Txterm setaf 6)
RESET  := $(shell tput -Txterm sgr0)

TARGET_MAX_CHAR_NUM := 20

# Define header
define HEADER
endef
export HEADER

# Required tools
REQUIRED_BINS := make cdk python
EVAL := FALSE

#Open Podman, only if is not running
run_podman:
	@ $(if $(shell command podman stats --no-stream 2> /dev/null), echo "✅ Podman is running.", echo "❌ Please run Podman." && exit 1)
.PHONY: run_podman

# Required Env variables
REQUIRED_VARIABLES := AWS_DEFAULT_REGION