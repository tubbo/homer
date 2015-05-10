#!/bin/zsh
#
# Commands that help support Homer's CLI.

# Render an error.
homer_error() {
  message=$1
  echo "ERROR: $message"
}

# Save a file to Git.
homer_add() {
  file=$1
  message=$2

  if [[ -z $message ]]; then
    echo "You must enter a message."
    exit 1
  fi

  pushd $HOMER_HOME
  git add -f $file && git commit $file -m "${message}"
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

  pushd $HOMER_HOME
  git rm -rf $file && git commit -m "${message}"
  popd
}

# Commit all untracked files to Git.
homer_add_all() {
  message=$1
  pushd $HOMER_HOME
  git add -f . && git commit -m "${message}"
  popd
}

# Update the git repo in the home directory with the latest changes from
# GitHub.
homer_update_repo() {
  pushd $HOMER_HOME
  git stash save
  git pull --rebase origin master
  git push origin master
  git stash pop
  popd
}
