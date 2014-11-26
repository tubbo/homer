#!/usr/bin/env bats

teardown() {
  rm -rf $BATS_TMPDIR/.git
}

@test "initialize a git repo in the home dir" {
  export HOME=$BATS_TMPDIR
  ./bin/homer init
}

@test "print an error and exit if git repo already exists" {
  export HOME=$BATS_TMPDIR
  mkdir -p $BATS_TMPDIR/.git/
  touch $BATS_TMPDIR/.git/ORIG_HEAD
  ./bin/homer init
}
