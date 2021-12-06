# REGISTRY_PROJECT_URL ?= my-awesome-registry.org/my-cool-project
# BUILD_ID = commit_sha
BUILD_ID ?=$(shell test -d .git && git rev-parse HEAD | cut -c -8)
# REF_ID = branch_name
REF_ID ?=$(shell test -d .git && git symbolic-ref --short HEAD)

default: help
include makefiles/*.mk

.PHONY: start
start: docker-compose-build docker-compose-start ##- Start
.PHONY: deploy
deploy: docker-compose-build docker-compose-deploy ##- Deploy (start remotely)
.PHONY: stop
stop: docker-compose-stop ##- Stop

clean: environment
	$(load_env); docker-compose ${compose_files} down -v

.PHONY: console
console: environment ##- Enter interactive console
	$(info *** Starting console ***)
	$(load_env); docker-compose exec archiver /bin/ash

## Test

.PHONY: set-test-docker-compose-files
set-test-docker-compose-files:
	$(eval compose_files=-f docker-compose.yml -f docker-compose.test.yml)

test: set-test-docker-compose-files docker-compose-build docker-compose-start environment
	$(load_env); docker-compose ${compose_files} ps
	$(load_env); docker-compose ${compose_files} exec archiver /bin/ash

