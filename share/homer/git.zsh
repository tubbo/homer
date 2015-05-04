#!/bin/zsh
#
# Commands that help support Homer's CLI.

if [ -z $HOME_DIR ]; then
  HOME_DIR=$HOME
fi

# Save a file to Git.
homer_add() {
  file=$1
  message=$2

  if [[ -z $message ]]; then
    echo "You must enter a message."
    exit 1
  fi

  pushd $HOME_DIR
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

  pushd $HOME_DIR
  git rm -rf $file && git commit -m "${message}"
  popd
}

# Commit all untracked files to Git.
homer_add_all() {
  message=$1
  homer_add '.' $message
}

# Update the git repo in the home directory with the latest changes from
# GitHub.
homer_update_repo() {
  pushd $HOME_DIR
  git stash save
  git pull --rebase origin master
  git push origin master
  git stash pop
  popd
}
