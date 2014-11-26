#!/bin/zsh
#
# Sets up the Homer shell framework.

# Load dependencies
source "/usr/local/lib/antigen.zsh"

# Load the framework
for file in `ls /usr/local/lib/homer`; do
  source "/usr/local/lib/homer/$file"
done

# Configure a basic prompt string
export PROMPT="♬  "

# Add user path on top so ~/bin files override the main $PATHs.
export PATH=$HOME/bin:$PATH

# Load user plugins
source "$HOME/etc/plugins.zsh"

# Load user aliases
source "$HOME/etc/aliases.zsh"

# Load user profile configuration
for file in `ls $HOME/etc/profile.d`; do
  source "$HOME/etc/profile.d/$file"
done
