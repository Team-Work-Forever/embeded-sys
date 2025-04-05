PROTO_PATH=proto
DART_PROTO_PATH=./mobile/lib/services/proto
GO_PROTO_PATH=./server/internal/services/proto

run: help

.PHONY: help
help:
	@echo "Makefile for managing Project tools"
	@echo
	@echo "Tools:"
	@echo "  install-tools			- Download and install proto related tools"
	@echo
	@echo "Actions:"
	@echo "  gen			- generate proto files"
	@echo "  gen-flutter			- generate proto files for the mobile application"
	@echo "  gen-go			- generate proto files for the server application"

.PHONY: install-tools
install-tools:
	@echo "Installing tools..."
	go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
	go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest
	go install github.com/pressly/goose/v3/cmd/goose@latest
	go install github.com/air-verse/air@latest
	@echo "Done..."
	@$(MAKE) gen-go
	@$(MAKE) gen-flutter

.PHONY: gen
gen: gen-flutter gen-go

.PHONY: gen-flutter
gen-flutter: 
	# @echo "Activating proto generation for flutter..."
	@dart pub global activate protoc_plugin
	mkdir -p $(DART_PROTO_PATH)
	protoc -I=$(PROTO_PATH) --dart_out=grpc:$(DART_PROTO_PATH) $(PROTO_PATH)/*

.PHONY: gen-go
gen-go:
	@echo "Generating proto files..."
	@protoc --proto_path=$(PROTO_PATH) --go_out=. --go-grpc_out=. $(PROTO_PATH)/*
	@echo "Done..."