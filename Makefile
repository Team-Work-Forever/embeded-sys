.PHONY: help
help:
	@echo "Makefile for managing Project tools"
	@echo
	@echo "Tools:"
	@echo "  install-tools			- Download and install proto related tools"
	@echo
	@echo "Actions:"
	@echo "  serve-server			- serve server locally with docker"
	@echo "  take-server			- take down server locally with docker"
	@echo "  gen-proto			- generate proto files on both server and mobile"

.PHONY: setup-project
setup-project:
	$(MAKE) -C mobile install-tools
	$(MAKE) -C server install-tools
	@echo "Ready..."

.PHONY: serve-server
serve-server: 
	@COMPOSE_BAKE=true docker compose -f ./server/docker-compose.yml up --build -d

.PHONY: take-server
take-server: 
	@COMPOSE_BAKE=true docker compose -f ./server/docker-compose.yml down

.PHONY: gen-proto
gen-proto:
	@echo "Generating proto files on mobile..."
	$(MAKE) -C mobile gen-proto
	@echo "Generating proto files on server..."
	$(MAKE) -C server gen-proto