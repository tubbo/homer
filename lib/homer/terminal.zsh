#!/bin/zsh
#
# Configuration for the terminal emulator using this shell.

# Force 256 color terminals
TERM=screen-256color

# Don't set iTerm/Terminal's title automatically.
DISABLE_AUTO_TITLE="true"

# Display red dots when ZSH is hanging.
COMPLETION_WAITING_DOTS="true"

# Colorize Grep
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;32'
