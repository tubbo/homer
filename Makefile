# Build scripts for Homer. These tasks will generate documentation,
# commands, and of course install the Homer scripts themselves to an
# executable location.
#
# Shoutouts to @postmodern and @isaacs, I lifted most of their ideas to
# make this...

.PHONY: test check install uninstall clean command all release

PROGRAM=homer
SHELL=/usr/bin/env zsh
PREFIX?=$(DESTDIR)/usr/local
HOMER_PATH?=$(PWD)
SOURCE_PATH?=$(PWD)
DIRS=bin share
INSTALL_DIRS=`find $(DIRS) -type d`
INSTALL_FILES=`find $(DIRS) -type f`
VERSION=`cat share/homer/VERSION`

# Install this script to /usr/local
all: clean test share/man/man1/homer.1 install

# Install gem dependencies
vendor/bundle:
	@bundle check || bundle install

# Remove generated files
clean:
	@rm -rf share/man/man1/homer.1 tmp/

# Run BATS tests on Homer
test:
	@bats test
check: test

# Generate the man page from markdown
share/man/man1/homer.1: vendor/bundle share/doc/man/homer.1.md
	@bundle exec kramdown-man share/doc/man/homer.1.md > share/man/man1/homer.1

# Move scripts to /usr/local. Typically requires `sudo` access.
install:
	for dir in $(INSTALL_DIRS); do mkdir -p $(DESTDIR)$(PREFIX)/$$dir; done
	for file in $(INSTALL_FILES); do cp $$file $(DESTDIR)$(PREFIX)/$$file; done

# Remove scripts from /usr/local. Typically requires `sudo` access.
uninstall:
	@rm -rf $(PREFIX)/$(DIRS)/$(PROGRAM)

# Generate a new command
command:
	@cp share/homer/command/bin.sh bin/homer-${NAME}
	@cp share/homer/command/doc.txt share/doc/commands/${NAME}.txt

# Create a new release
release:
	@echo "git tag $(VERSION) && git push --tags"
