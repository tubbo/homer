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

all: test install

test:
	bats test

dependencies:
	pip install git+git://github.com/Lokaltog/powerline

install: dependencies
	for dir in $(INSTALL_DIRS); do mkdir -p $(PREFIX)/$$dir; done
	for file in $(INSTALL_FILES); do cp $$file $(PREFIX)/$$file; done

uninstall: clean
	for file in $(INSTALL_FILES); do rm -f $(PREFIX)/$$file; done

clean:
	pip uninstall powerline

.PHONY: test dependencies install uninstall all
