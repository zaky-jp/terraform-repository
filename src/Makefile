include ../.config/make/common

# constant
DEBIAN_FILES := debian/control debian/changelog debian/rules debian/compat debian/license
DEBHELPER_FILES := debian/$(PACKAGE_NAME) debian/.debhelper debian/debhelper-build-stamp debian/files debian/$(PACKAGE_NAME).substvars
KEYRING_FILE := debian/$(PACKAGE_NAME)/usr/share/keyrings/hashicorp-archive-keyring.asc
SOURCES_FILE := debian/$(PACKAGE_NAME)/etc/apt/sources.list.d/terraform.sources

# targets
debian/changelog:
	debchange --create --package $(PACKAGE_NAME) --newversion $(VERSION) Initial release
# cspell: ignore newversion

debian/compat:
	echo "13" > debian/compat

debian/license:
	[[ -L debian/license ]] || ln -s ../../LICENSE debian/license

$(dir $(KEYRING_FILE)):
	mkdir -p $(dir $(KEYRING_FILE))

$(KEYRING_FILE): $(dir $(KEYRING_FILE)) download_keyring.sh
	./download_keyring.sh $(KEYRING_FILE)

$(dir $(SOURCES_FILE)):
	mkdir -p $(dir $(SOURCES_FILE))

$(SOURCES_FILE): $(dir $(SOURCES_FILE)) terraform.sources
	cp terraform.sources $(SOURCES_FILE)

# verbs
.PHONY: debuild
debuild: $(DEBIAN_FILES)
	debuild -i -us -uc -b

.PHONY: bump
bump: debian/changelog
	debchange --newversion $(VERSION)

.PHONY: install
install: $(KEYRING_FILE) $(SOURCES_FILE);

.PHONY: clean
clean:
	rm -r $(addprefix ./, $(DEBHELPER_FILES)) || true

.PHONY: all
all: debian/changelog
	debchange --release ""
