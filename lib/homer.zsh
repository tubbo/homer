#!/bin/zsh
#
# Sets up the Homer shell framework.

# Load dependencies
source "/usr/local/lib/antigen.zsh"

# Load framework files
for file in `ls /usr/local/lib/homer`; do
  source "/usr/local/lib/homer/$file"
done
