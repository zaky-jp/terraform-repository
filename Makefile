include .config/make/common

# constant
ARTIFACT_DIR := ./artifacts

# targets
$(ARTIFACT_DIR):
	mkdir -p $(ARTIFACT_DIR)

# verbs
.PHONY: cspell
cspell: package.json
	npm install

.PHONY: bump
bump:
	$(MAKE) -C src bump

.PHONY: debian-package
debian-package:
	$(MAKE) clean && \
	$(MAKE) -C src debuild && \
	$(MAKE) move-artifacts

.PHONY: move-artifacts
move-artifacts: $(ARTIFACT_DIR)
	mv $(wildcard $(PACKAGE_NAME)*) $(ARTIFACT_DIR)

.PHONY: clean
clean:
	rm -r $(ARTIFACT_DIR) || true

