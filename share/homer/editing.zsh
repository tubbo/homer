#!/bin/zsh
#
# Configuration for text editing.

EDITOR='vi'
PAGER='more'

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
