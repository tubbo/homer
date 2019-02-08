#!/usr/bin/env bats

load test_helper

alias_string="alias hello-world='echo hello world'"

@test "add an alias" {
  $HOMER init
  run $HOMER alias hello-world 'echo "hello world"'

  assert_success
  assert_output --partial "Add alias hello-world"
}

@test "remove an alias" {
  $HOMER init
  echo $alias_string >> $HOMER_HOME/etc/aliases.zsh

  run $HOMER alias hello-world -r

  assert_success
  assert_output --partial "Remove alias hello-world"
}
