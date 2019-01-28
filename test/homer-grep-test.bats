#!/usr/bin/env bats

load test_helper

@test "search the home directory repo" {
  run $HOMER init

  assert [ "$(./bin/homer grep page | wc -l)" -ge 1 ]
}
