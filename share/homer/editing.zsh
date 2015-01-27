#!/bin/zsh
#
# Configuration for text editing.

if [ -n "${EDITOR+x}" ]; then
  # do nothing, var is set
else
  EDITOR='vi'
fi

if [ -n "${PAGER+x}" ]; then
  # do nothing, var is set
else
  # use the posix-compliant variant
  PAGER='less'
fi

# Execute as the configured editor.
edit() {
  $EDITOR $*
}
alias e=edit

# Execute as the configured pager.
page() {
  $PAGER $*
}
alias v=page

# Print a given string.
alias p=echo

# Clear the screen
alias c=clear
