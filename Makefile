# REGISTRY_PROJECT_URL ?= my-awesome-registry.org/my-cool-project
# BUILD_ID = commit_sha
BUILD_ID ?=$(shell test -d .git && git rev-parse HEAD | cut -c -8)
# REF_ID = branch_name
REF_ID ?=$(shell test -d .git && git symbolic-ref --short HEAD)

default: help
include makefiles/*.mk

.PHONY: set-test-docker-compose-files
set-test-docker-compose-files:
	$(eval compose_files=-f docker-compose.yml -f docker-compose.test.yml)

test: set-test-docker-compose-files docker-compose-build docker-compose-start environment
	$(load_env); docker-compose ${compose_files} ps
	$(load_env); docker-compose ${compose_files} exec archiver /bin/ash
