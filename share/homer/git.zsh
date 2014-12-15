#!/bin/zsh
#
# Commands that help support Homer's CLI.

# Save a file to Git.
homer_add() {
  file=$1
  message=$2

  if [[ -z $message ]]; then
    echo "You must enter a message."
    exit 1
  fi

  pushd $HOME
  git add $file && git commit $file -m "${message}"
  popd
}

# Remove a file from Git.
homer_remove() {
  file=$1
  message=$2

  if [[ -z $message ]]; then
    echo "You must enter a message."
    exit 1
  fi

  pushd $HOME
  git rm -rf $file && git commit -m "${message}"
  popd
}

# Commit all untracked files to Git.
homer_commit_all() {
  message=$1

  if [[ -z $message ]]; then
    echo "You must enter a message."
    exit 1
  fi

  pushd $HOME
  git add . && git commit -m $message
  popd
}

# Find the current version of Homer.
homer_find_version() {
  pushd $HOMER_PATH
  git tag | tail -n 1
  popd
}

# Update the git repo in the home directory with the latest changes from
# GitHub.
homer_update_repo() {
  pushd $HOME
  git stash save
  git pull --rebase origin master
  git push origin master
  git stash pop
  popd
}
