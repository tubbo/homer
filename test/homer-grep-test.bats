#!/usr/bin/env bats

load test_helper

@test "search the home directory repo" {
  $HOMER init > /dev/null 2>&1
  echo page > $HOMER_HOME/.dotfile
  pushd $HOMER_HOME
  git add -f .dotfile
  git commit .dotfile -m "created dotfile"
  popd

  run $HOMER grep page

  assert_success
  assert_line --index 0 --partial ".dotfile"
  assert_line --index 1 --partial "/usr/local/share/homer/editing.zsh"
}
