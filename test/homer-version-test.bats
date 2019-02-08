#!/usr/bin/env bats

load test_helper

@test "print current version" {
  run $HOMER version

  assert_success
  assert_output "$(cat $PWD/share/homer/VERSION)"
}
