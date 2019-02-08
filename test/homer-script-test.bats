#!/usr/bin/env bats

load test_helper

@test "save an executable script to bin/" {
  $HOMER init

  echo 'echo hello world' > $BATS_TMPDIR/foo

  run $HOMER script $BATS_TMPDIR/foo

  assert_success
  assert_output --partial "Add script foo"
}

@test "save an executable script to bin/ with custom msg" {
  $HOMER init

  echo 'echo hello world' > $BATS_TMPDIR/foo

  run $HOMER script $BATS_TMPDIR/foo -m "Add foo"

  assert_success
  assert_output --partial "Add foo"
}



@test "remove an executable script from bin/" {
  $HOMER init
  pushd $HOMER_HOME
  echo 'echo hello world' > bin/foo
  git add -f bin/foo
  git commit -m "Add script foo"
  popd

  run $HOMER script $BATS_TMPDIR/foo -r

  assert_success
  assert_output --partial "Remove script foo"
}
