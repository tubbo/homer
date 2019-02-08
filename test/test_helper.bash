#!/usr/local/bin/bash

# Load BATS plugins
VENDOR_PATH=../node_modules

load "${VENDOR_PATH}/bats-support/load"
load "${VENDOR_PATH}/bats-assert/load"
load "${VENDOR_PATH}/bats-file/load"

export SOURCE_DIR="$(dirname $BATS_TEST_DIRNAME)"
export HOMER=$BATS_TEST_DIRNAME/../bin/homer

setup() {
  export HOMER_HOME="$BATS_TMPDIR/home"
  mkdir -p $HOMER_HOME
}

teardown() {
  rm -rf $HOMER_HOME $BATS_TMPDIR/remote $BATS_TMPDIR/repo $BATS_TMPDIR/foo
}
