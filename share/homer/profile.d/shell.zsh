#!/bin/zsh
#
# Configuration for ZSH, the underlying shell

# Use ZSH online help
unalias run-help
autoload run-help
HELPDIR=/usr/local/share/zsh/helpfiles

# Enable vi mode
bindkey -v

# Re-bind history search actions so that the text already typed into
# the prompt is used to filter results. When typing "rake" into the
# prompt and hitting the up arrow, only results that match /^rake/
# will be returned.
bindkey '^R' history-incremental-search-backward
bindkey '\e[A' history-beginning-search-backward
bindkey '\e[B' history-beginning-search-forward

# SSH agent forwarding
zstyle :omz:plugins:ssh-agent agent-forwarding on
