#!/bin/zsh
#
# Set up the Homer shell framework.

# Remember the path to homer's code
if [ -z $HOMER_PREFIX ]; then
  export HOMER_PREFIX="/usr/local"
fi

# Use a copy of the $HOME alias if no home path defined
if [ -z $HOMER_HOME ]; then
  export HOMER_HOME=$HOME
fi

# Configure a basic prompt string
export PROMPT="♬  "

# Add user path on top so ~/bin files override the main $PATHs.
export PATH=$HOME/bin:$PATH
export HOMER_PATH=$HOMER_PREFIX/share/homer

# Load the framework
for filepath in `ls $HOMER_PATH/profile.d/`; do
  source "$filepath"
done

# Load user plugins
source "$HOMER_HOME/etc/plugins.zsh"

# Load user aliases
source "$HOMER_HOME/etc/aliases.zsh"

# Load user profile configuration
for file in `ls $HOMER_HOME/etc/profile.d`; do
  source "$HOMER_HOME/etc/profile.d/$file"
done
