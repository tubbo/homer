#!/usr/bin/env bats

load test_helper

@test "save a dotfile to the home dir" {
  $HOMER init
  touch $HOMER_HOME/.dotfile
  run $HOMER save .dotfile -m "Added dotfile"

  assert_success
  assert_line --partial "Added dotfile"
}

@test "remove a dotfile from the home dir" {
  $HOMER init
  run $HOMER save README.md -r -m "Removed README"

  assert_success
  assert_line --partial "Removed README"
}

@test "prevent saving dotfile without a commit message" {
  $HOMER init
  touch $HOMER_HOME/.dotfile
  run $HOMER save .dotfile

  assert_failure
  assert_output "You must enter a message."
}
