#!/bin/zsh
#
# ZSH master shell configuration. It should pretty much have nothing but
# `homer load` in it, other than your own variable settings.

# Load the Homer shell framework
homer load

# Make Ruby even faster
RUBY_HEAP_MIN_SLOTS=1000000
RUBY_HEAP_SLOTS_INCREMENT=1000000
RUBY_HEAP_SLOTS_GROWTH_FACTOR=1
RUBY_GC_MALLOC_LIMIT=1000000000
RUBY_HEAP_FREE_MIN=500000

# Text editing and paging
EDITOR='vim'
PAGER='less -R'
