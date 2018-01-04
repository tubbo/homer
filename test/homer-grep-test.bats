#!/usr/bin/env bats

@test "searches the home directory repo" {
  [ "$(./bin/homer grep page | wc -l)" -ge 1 ]
}
