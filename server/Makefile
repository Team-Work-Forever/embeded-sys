# Proto directory
PROTO_PATH=../proto
GOOSE_BIN=goose

# Migration directory
MIGRATION_DIR=migrations

# Load .env variables file
ifneq (,$(wildcard ./.env))
    include .env
    export
endif

run: help

.PHONY: help
help:
	@echo "Makefile for managing Project tools"
	@echo
	@echo "Execute:"
	@echo "  serve				- serve the application"
	@echo "  dev				- serve application in development mode with hot reload"
	@echo
	@echo "Database:"
	@echo "  rollback			- Rollback the last migration"
	@echo "  rebuild			- Rebuild migrations"
	@echo "  reset				- Rollback all the migrations"
	@echo "  status			- Show the current migration status"
	@echo "  migrate			- Apply all pending migrations"
	@echo "  create-migration		- Create a new migration with a user-provided name"

.PHONY: serve
serve:
	@go run ./cmd/server/main.go

.PHONY: dev
dev:
	@air

.PHONY: create-db
create-db:
	@sqlite3 $(DB_SQL_PATH) "VACUUM;"
	@echo "Done..."

.PHONY: rollback
rollback:
	@echo "Rolling back the last migration..."
	@$(GOOSE_BIN) -dir $(MIGRATION_DIR) sqlite3 $(DB_SQL_PATH) down

.PHONY: rebuild
rebuild: reset migrate

.PHONY: reset
reset:
	@echo "Rolling back all migrations..."
	@$(GOOSE_BIN) -dir $(MIGRATION_DIR) sqlite3 $(DB_SQL_PATH) reset

.PHONY: status
status:
	@echo "Checking migration status..."
	@$(GOOSE_BIN) -dir $(MIGRATION_DIR) sqlite3 $(DB_SQL_PATH) status

.PHONY: migrate
migrate:
	@echo "Applying migrations..."
	@$(GOOSE_BIN) -dir $(MIGRATION_DIR) sqlite3 $(DB_SQL_PATH) up

.PHONY: create-migration
create-migration:
	@if [ -z "$(name)" ]; then \
		echo "Error: Migration name is required."; \
		echo "	like: make create-migration name=<migration>"; \
		exit 1; \
	fi
	@echo "Creating migration with name: $(name)"
	@$(GOOSE_BIN) -dir $(MIGRATION_DIR) create $(name) sql
