#!/usr/bin/env bats

load test_helper

@test "show usage information" {
  run $HOMER help

  assert_success
  assert_output --partial "Usage: homer COMMAND [ARGUMENTS]"
}

@test "show information on command" {
  run $HOMER help init

  assert_success
  assert_output --partial "Sets up your home directory for use with Homer."
}
