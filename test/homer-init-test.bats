#!/usr/bin/env bats

setup() {
  mkdir $PWD/tmp
}

teardown() {
  rm -rf $PWD/tmp
}

@test "initialize a git repo in the home dir" {
  export HOME="$PWD/tmp"
  ./bin/homer init
}

@test "print an error and exit if git repo already exists" {
  export HOME=$PWD/tmp
  mkdir -p $PWD/tmp/.git/
  touch $PWD/tmp/.git/ORIG_HEAD
  ./bin/homer init
}
