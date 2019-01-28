#!/usr/bin/env bats

load test_helper

setup() {
  export HOMER_HOME="$BATS_TMPDIR/home"
  mkdir -p $HOMER_HOME
}

assert_error() {
  assert_output "ERROR: $1"
}

@test "initialize a git repo in the home dir" {
  run $PWD/bin/homer init

  assert_success
  assert_file_exist $BATS_TMPDIR/home/etc/aliases.zsh
  assert_file_exist $BATS_TMPDIR/home/etc/plugins.zsh
  assert_file_exist $BATS_TMPDIR/home/bin/.keep
}

@test "print an error and exit if git repo already exists" {
  mkdir -p $HOMER_HOME/.git
  touch $HOMER_HOME/.git/ORIG_HEAD

  run $PWD/bin/homer init

  assert_failure
  assert_error "There is already an existing Git repository in $HOMER_HOME."

  rm -rf $HOMER_HOME
}
