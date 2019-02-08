# Build scripts for Homer. These tasks will generate documentation,
# commands, and of course install the Homer scripts themselves to an
# executable location.
#
# Shoutouts to @postmodern and @isaacs, I lifted most of their ideas to
# make this...

.PHONY: build test check install uninstall clean command release verify

PROGRAM=homer
SHELL=/usr/bin/env zsh
PREFIX?=$(DESTDIR)/usr/local
HOMER_PATH?=$(PWD)
SOURCE_PATH=$(PWD)
DIRS=bin share
INSTALL_DIRS=`find $(DIRS) -type d`
INSTALL_FILES=`find $(DIRS) -type f`
VERSION_FILE=$(SOURCE_PATH)/share/homer/VERSION
VERSION=$(shell cat ${VERSION_FILE})

PKG_DIR=dist
PKG_NAME=$(PROGRAM)-$(VERSION)
PKG=$(PKG_DIR)/$(PKG_NAME).tar.gz
TAG=.git/refs/tags/$(VERSION)
SIG=$(PKG).asc

# Install this script to /usr/local
build: share/man/man1/homer.1 $(PKG) $(SIG)

# Install gem dependencies
vendor/bundle:
	@bundle check || bundle install

# Remove generated files
clean:
	@rm -rf tmp dist share/man/man1

# Run BATS tests on Homer
test:
	@bats test
check: test

# Generate the man page from markdown
share/man/man1:
	@mkdir -p share/man/man1
share/man/man1/homer.1: vendor/bundle share/doc/man/homer.1.md share/man/man1
	@bundle exec kramdown-man share/doc/man/homer.1.md > share/man/man1/homer.1

# Move scripts to /usr/local. Typically requires `sudo` access.
install:
	@for dir in $(INSTALL_DIRS); do mkdir -p $(DESTDIR)$(PREFIX)/$$dir; done
	@for file in $(INSTALL_FILES); do cp $$file $(DESTDIR)$(PREFIX)/$$file; done

# Remove scripts from /usr/local. Typically requires `sudo` access.
uninstall:
	@rm -rf $(PREFIX)/$(DIRS)*$(PROGRAM)*

# Generate a new command
command:
	@cp share/homer/command/bin.sh bin/homer-${NAME}
	@cp share/homer/command/doc.txt share/doc/homer/${NAME}.txt
	@cp share/homer/command/test.bats test/homer-${NAME}-test.bats
	@chmod +x bin/homer-${NAME}

# Tag the current state of the codebase as a released version
$(TAG):
	@git tag v$(VERSION)

# Create a package for the current version of the codebase. This
# omits developer-centric files like tests and build manifests for the
# released version of the package.
$(PKG_DIR):
	@mkdir -p $(PKG_DIR)
$(PKG): $(PKG_DIR)
	@git archive --output=$(PKG) --prefix=$(PKG_NAME)/ HEAD $(DIRS) ./Makefile

# Cryptographically sign the package so its contents can be verified at
# a later date
$(SIG): $(PKG)
	@gpg --sign --detach-sign --armor $(PKG)

# Release the latest version of Homer to GitHub
release: $(TAG) $(PKG) $(SIG)
	@git push --all --tags

# Verify the contents of a package
verify: $(PKG) $(SIG)
	@gpg --verify $(SIG) $(PKG)
