#!/bin/zsh
#
# Configuration for text editing.

# Execute as the configured editor.
edit() {
  exec "$EDITOR $*"
}
alias e=editor

# Execute as the configured pager.
page() {
  exec "$PAGER $*"
}
alias v=reader

# Print a given string.
alias p=echo
