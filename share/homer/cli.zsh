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

_homer_brew() {
  case "$1" in
    taps)
      for tap in `cat $HOMER_HOME/etc/brew/taps`; do
        brew tap $tap
      done
      ;;
    packages)
      for package in `cat $HOMER_HOME/etc/brew/packages`; do
        brew install $package
      done
      ;;
    casks)
      for cask in `cat $HOMER_HOME/etc/brew/casks`; do
        brew cask install $cask
      done
      ;;
    *)
      _homer_brew taps
      _homer_brew packages
      _homer_brew casks
      ;;
  esac
}

homer_brew() {
  if (( $+commands[brew] )) ; then
    brew update
    _homer_brew
  fi
}
