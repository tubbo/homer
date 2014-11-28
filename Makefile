#
# Makefile for Homer
#

SHELL=/usr/bin/env zsh
NAME=homer
VERSION=master
AUTHOR=tubbo
URL=https://github.com/$(AUTHOR)/$(NAME)

DIRS=bin etc lib share
INSTALL_DIRS=`find $(DIRS) -type d`
INSTALL_FILES=`find $(DIRS) -type f`

PREFIX?=$(DESTDIR)/usr/local

all: clean test install

test:
	bats test

share/man/man1/homer.1: doc/man/homer.1.md
	kramdown-man doc/man/homer.1.md > share/man/man1/homer.1

man: share/man/man1/homer.1
	git add share/man/man1/homer.1

install:
	for dir in $(INSTALL_DIRS); do mkdir -p $(PREFIX)/$$dir; done
	for file in $(INSTALL_FILES); do cp $$file $(PREFIX)/$$file; done

clean:
	for file in $(INSTALL_FILES); do rm -f $(PREFIX)/$$file; done

.PHONY: test dependencies install clean all
