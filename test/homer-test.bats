#!/usr/bin/env bats

@test "runs an executable when given a proper command" {
  ./bin/homer usage
  [ "$?" -eq 0 ]
}
