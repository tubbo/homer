#!/usr/bin/env bats

load test_helper

@test "save an executable script to bin/" {
  $HOMER init

  echo 'echo hello world' >> $BATS_TMPDIR/foo

  run $HOMER script $BATS_TMPDIR/foo

  assert_success
  assert_output --partial "Add script foo"
}

@test "remove an executable script from bin/" {
  $HOMER init
  echo 'echo hello world' >> $BATS_TMPDIR/foo

  run $HOMER script $BATS_TMPDIR/foo -r

  assert_success
  assert_output --partial "Remove script foo"
}
