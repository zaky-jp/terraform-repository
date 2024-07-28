# makefile config
SHELL := bash
.SHELLFLAGS := -eu -o pipefail -c
.DEFAULT_GOAL := all

# constant
DEBIAN_FILES := debian/control debian/changelog debian/rules debian/compat debian/license
DEBHELPER_FILES := debian/$(PACKAGE_NAME) debian/.debhelper debian/debhelper-build-stamp debian/files debian/$(PACKAGE_NAME).substvars
KEYRING_FILE := debian/$(PACKAGE_NAME)/usr/share/keyrings/hashicorp-archive-keyring.asc
SOURCES_FILE := debian/$(PACKAGE_NAME)/etc/apt/sources.list.d/terraform.sources
DEBFULLNAME := Rintaro Kanzaki
DEBEMAIL := 105104188+zaky-jp@users.noreply.github.com

# targets
debian/changelog:
	debchange --create --package $(PACKAGE_NAME) --newversion $(VERSION) Initial release
# cspell: ignore newversion

debian/compat:
	echo "13" > debian/compat

debian/license:
	[[ -L debian/license ]] || ln -s ../../LICENSE debian/license

$(KEYRING_FILE):
	mkdir -p $(dir $(KEYRING_FILE)) \
	&& ./download_keyring.sh $(KEYRING_FILE)

$(SOURCES_FILE):
	mkdir -p $(dir $(SOURCES_FILE)) \
	&& cp terraform.sources $(SOURCES_FILE)

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
# when called from debuild, it will not inherit root make exports
# thus needs to understand if PACKAGE_NAME is already defined
ifneq (, $(PACKAGE_NAME))
	rm -r $(addprefix ./, $(DEBHELPER_FILES)) || true
endif

.PHONY: all
all: debian/changelog
	debchange --release ""
