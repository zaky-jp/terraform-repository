# makefile config
SHELL := bash
.SHELLFLAGS := -eu -o pipefail -c
.DEFAULT_GOAL := all

# constant
ARTIFACT_DIR := ./artifacts
export PACKAGE_NAME := terraform-repository
export VERSION := 0.0.1

# targets
$(ARTIFACT_DIR):
	mkdir -p $(ARTIFACT_DIR)

# verbs
.PHONY: cspell
cspell:
	npm install

.PHONY: bump
bump:
	$(MAKE) -C src bump

.PHONY: debian-package
debian-package:
	$(MAKE) clean && \
	$(MAKE) $(ARTIFACT_DIR) && \
	$(MAKE) -C src debuild && \
	mv $(wildcard $(PACKAGE_NAME)*) $(ARTIFACT_DIR)

.PHONY: clean
clean:
	rm -r $(ARTIFACT_DIR) || true ;\
	$(MAKE) -C src clean

