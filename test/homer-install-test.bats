#!/usr/bin/env bats

load test_helper

@test "install the latest version with the installer script" {
  run docker run --rm -it homer:latest homer version

  assert_success
  assert_output $(cat $SOURCE_DIR/share/homer/VERSION)
}
