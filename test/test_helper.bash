#!/usr/local/bin/bash

TEST_BREW_PREFIX="$(brew --prefix)"

load "${TEST_BREW_PREFIX}/lib/bats-support/load.bash"
load "${TEST_BREW_PREFIX}/lib/bats-assert/load.bash"
load "${TEST_BREW_PREFIX}/lib/bats-file/load.bash"
