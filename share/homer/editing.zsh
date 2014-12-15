#!/bin/zsh
#
# Configuration for text editing.

# Execute as the configured editor.
edit() {
  $EDITOR $*
}
alias e=editor

# Execute as the configured pager.
page() {
  $PAGER $*
}
alias v=reader

# Print a given string.
alias p=echo
