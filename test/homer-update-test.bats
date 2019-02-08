#!/usr/bin/env bats

load test_helper

@test "sync with remote repository" {
  $HOMER init
  git init $BATS_TMPDIR/remote --bare
  pushd $HOMER_HOME
  git remote add origin $BATS_TMPDIR/remote
  git push origin master
  popd

  run $HOMER update

  assert_success
  assert_output --partial "Updated home directory $HOMER_HOME with the latest changes."
}
