PROTO_PATH=../proto
DART_PROTO_PATH=./lib/services/proto

.PHONY: help
help:
	@echo "Makefile for Mobile Project tools"
	@echo
	@echo "Tools:"
	@echo "  install-tools			- Download and install proto related tools"
	@echo
	@echo "Actions:"
	@echo "  locales-gen			- Generate languages for the mobile app"
	@echo "  gen-proto			- generate proto files for the mobile application"

.PHONY: install-tools
install-tools:
	@echo "Setup project..."
	@flutter pub get
	@$(MAKE) locales-gen

.PHONY: locales-gen
locales-gen:
	@echo "Generating locales..."
	@flutter gen-l10n --arb-dir lib/core/locales/l10n

.PHONY: gen-proto
gen-proto: 
	# @echo "Activating proto generation for flutter..."
	@dart pub global activate protoc_plugin
	mkdir -p $(DART_PROTO_PATH)
	protoc -I=$(PROTO_PATH) --dart_out=grpc:$(DART_PROTO_PATH) $(PROTO_PATH)/* google/protobuf/timestamp.proto google/protobuf/empty.proto
