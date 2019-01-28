#!/usr/bin/env bats

load test_helper

@test "add a plugin to the manifest" {
  run $HOMER plugin zsh-users/zsh-syntax-highlighting

  assert_success
}

@test "remove a plugin from the manifest" {
}
