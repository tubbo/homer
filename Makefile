#
# Makefile for Homer
#


.PHONY: test dependencies install clean all

SHELL=/usr/bin/env zsh
DIRS=bin etc lib share
INSTALL_DIRS=`find $(DIRS) -type d`
INSTALL_FILES=`find $(DIRS) -type f`

PREFIX?=$(DESTDIR)/usr/local

HOMER_PATH?=$(PWD)

# Install this script to /usr/local
all: clean test man install

# Remove generated files
clean:
	rm -rf share/man/man1/homer.1 tmp/

# Run BATS test on Homer
test:
	bats test

# Generate the man page from markdown
share/man/man1/homer.1: doc/man/homer.1.md
	kramdown-man doc/man/homer.1.md > share/man/man1/homer.1

# Commit man changes to Git
man: share/man/man1/homer.1
	git add share/man/man1/homer.1

# Move scripts to /usr/local
install:
	for dir in $(INSTALL_DIRS); do mkdir -p $(PREFIX)/$$dir; done
	for file in $(INSTALL_FILES); do cp $$file $(PREFIX)/$$file; done

# Remove scripts from /usr/local
uninstall:
	for file in $(INSTALL_FILES); do rm -f $(PREFIX)/$$file; done

# Generate the bin file for a command
command-bin:
	cp share/homer/command/bin.sh bin/homer-${NAME}

# Generate the documentation for a command
command-doc:
	cp share/homer/command/doc.txt doc/commands/${NAME}.txt

# Generate a new command
command: command-bin command-doc
