# Makefile for homer

DIRS=(bin lib share)

test:
	bats test

install:
	for d in ${DIRS}; do cp -a $d /usr/local/
