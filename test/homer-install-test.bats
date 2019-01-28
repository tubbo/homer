#!/usr/bin/env bats

load test_helper

setup() {
  if [ ! -z "$(command -v docker)" ]; then
    docker build -t homer:latest .
  fi
}

teardown() {
  if [ ! -z "$(command -v docker)" ]; then
    docker image rm homer:latest
  fi
}

@test "install the latest version with the installer script" {
  if [ -z "$(command -v docker)" ]; then
    skip "Install Docker to run integration tests"
  fi

  run docker run --rm -it homer:latest homer

  assert_success
  assert_line --partial "Usage: homer COMMAND [ARGUMENTS]"
}
