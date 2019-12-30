# Build scripts for Homer. These tasks will generate documentation,
# commands, and of course install the Homer scripts themselves to an
# executable location.
#
# Shoutouts to @postmodern and @isaacs, I lifted most of their ideas to
# make this...

.PHONY: all build test check install uninstall clean command release verify

PROGRAM=homer
SHELL=/usr/bin/env zsh
PREFIX?=$(DESTDIR)/usr/local
HOMER_PATH?=$(PWD)
SOURCE_PATH=$(PWD)
DIRS=bin share
INSTALL_DIRS=`find $(DIRS) -type d`
INSTALL_FILES=`find $(DIRS) -type f`
GITHUB_REF?=$(shell git show-ref $(git branch | grep '*') | head -n 1 | awk '{ print $2 }')
VERSION?=$(shell echo $(GITHUB_REF) | cut -d / -f 3)
DOCS=$(shell find share/doc/man/*.md -type f | sed 's/doc\/man/man\/man1/g' | sed 's/\.md//g')

PKG_DIR=dist
PKG_NAME=$(PROGRAM)-$(VERSION)
PKG=$(PKG_DIR)/$(PKG_NAME).tar.gz
TAG=.git/refs/tags/$(VERSION)
SIG=$(PKG).asc

# Build the documentation and tarball, then sign the package with GPG
all: $(DOCS) $(PKG) $(SIG)
build: all

# Install manpages generator
vendor/bundle:
	@bundle check || bundle install

# Remove all generated files
clean:
	@rm -rf tmp share/man/man1 dist

# Install the testing framework
node_modules:
	@yarn

# Run all tests
check: node_modules
	@node_modules/.bin/bats test
test: check

# Generate man pages from markdown
share/man/man1:
	@mkdir -p share/man/man1
docs/manual:
	@mkdir -p docs/manual
share/man/man1/%.1: vendor/bundle share/man/man1 docs/manual
	@bundle exec ronn --date="2014-11-01" --manual="User Manual" --organization="$(PROGRAM)" --style=dark share/doc/man/$(@F).md
	@mv share/doc/man/$(@F) share/man/man1/$(@F)
	@mv share/doc/man/$(@F).html docs/manual/$(@F).html

# Move scripts to /usr/local. Typically requires `sudo` access.
install:
	@for dir in $(INSTALL_DIRS); do mkdir -p $(DESTDIR)$(PREFIX)/$$dir; done
	@for file in $(INSTALL_FILES); do cp $$file $(DESTDIR)$(PREFIX)/$$file; done

# Remove scripts from /usr/local. Typically requires `sudo` access.
uninstall:
	@for file in $(INSTALL_FILES); do echo $$file; done

# Generate a new command
command:
	@cp share/homer/command/bin.sh bin/homer-${NAME}
	@cp share/homer/command/doc.txt share/doc/homer/${NAME}.txt
	@cp share/homer/command/test.bats test/homer-${NAME}-test.bats
	@chmod +x bin/homer-${NAME}

# Tag the current state of the codebase as a released version
$(TAG):
	@git tag $(VERSION) -m "Release $(VERSION)"

# Generate ctags
tags:
	@ctags -R .

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
	@gpg --batch --sign --detach-sign --armor $(PKG)

# Release the latest version of Homer to GitHub.
release: $(TAG)
	@git push origin --tags
	@git push origin master

# Verify the contents of a package
verify: $(PKG) $(SIG)
	@gpg --verify $(SIG) $(PKG)
