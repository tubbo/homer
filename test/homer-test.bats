#!/usr/bin/env bats

@test "runs an executable when given a proper command" {
  ./bin/homer help
}

@test "shows usage information when command not found" {
  ./bin/homer not-a-command
}
