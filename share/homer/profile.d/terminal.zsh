#!/bin/zsh
#
# Configuration for the terminal emulator using this shell.

# Force 256 color terminals
TERM=screen-256color

# Don't set iTerm/Terminal's title automatically.
DISABLE_AUTO_TITLE="true"

# Display red dots when ZSH is hanging.
COMPLETION_WAITING_DOTS="true"

# Set the title of the current terminal session
title() {
  print -Pn "\033];$1\007";
}
alias t=title
