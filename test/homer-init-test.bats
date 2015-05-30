#!/usr/bin/env bats

setup() {
  export SKIP_BREW='true'
}

@test "initialize a git repo in the home dir" {
  ./bin/homer init $BATS_TMPDIR/home
}

@test "print an error and exit if git repo already exists" {
  mkdir -p $BATS_TMPDIR/home/.git
  touch $BATS_TMPDIR/home/.git/ORIG_HEAD

  ./bin/homer init $BATS_TMPDIR/home
}
