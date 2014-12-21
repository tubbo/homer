#!/usr/bin/env bats

setup() {
  export HOME="$PWD/tmp"
  ./bin/homer init
}

teardown() {
  rm -rf $PWD/tmp
}

#@test "saves a dotfile to the home dir" {
#  export HOME="$PWD/tmp"
#  touch $HOME/.dotfile
#  ./bin/homer save .dotfile -m "dot file created"
#}
#
#@test "removes a dotfile from the home dir" {
#  export HOME="$PWD/tmp"
#  touch $HOME/.dotfile
#  pushd $HOME
#  git add .dotfile
#  git commit -m "dot file created"
#  popd $HOME
#  ./bin/homer save .dotfile -r -m "dot file destroyed"
#}
