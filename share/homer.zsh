#!/bin/zsh
#
# Set up the Homer shell framework.

# Remember the path to homer's code
if [ -z $HOMER_PREFIX ]; then
  export HOMER_PREFIX="/usr/local"
fi

# Set the version
export HOMER_VERSION="0.0.4.pre"

# Configure a basic prompt string
export PROMPT="♬  "

# Add user path on top so ~/bin files override the main $PATHs.
export PATH=$HOME/bin:$PATH

# Load the framework
for filepath in `ls $HOMER_PATH/share/homer/*.zsh`; do
  source "$filepath"
done

# Load user plugins
source "$HOME/etc/plugins.zsh"

# Load user aliases
source "$HOME/etc/aliases.zsh"

# Load user profile configuration
for file in `ls $HOME/etc/profile.d`; do
  source "$HOME/etc/profile.d/$file"
done
