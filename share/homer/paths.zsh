#!/bin/zsh

# Cache the path laid out in this file and `reset_path` if the shell
# gets confused.
export DEFAULT_PATH=$PATH
alias reset_path='export PATH=$DEFAULT_PATH'

# Load Java on OS X
export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Home/
