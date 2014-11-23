# Documentation PATHs
MANPATH=/usr/local/opt/coreutils/libexec/gnuman:$MANPATH

export PYTHONPATH=$HOME/.python/lib/python2.7/site-packages/
export GEMPATH=$HOME/.gem/ruby/2.0.0/bin/
export JSPATH=$HOME/node_modules/.bin/
export GEMPATHS=$PWD/bin:$PWD/vendor/gems/bin
export PATH=$PYTHONPATH:$GEMPATH:$JSPATH:$GEMPATHS:/bin:$PATH

# Cache the path laid out in this file and `reset_path` if the shell
# gets confused.
export DEFAULT_PATH=$PATH
alias reset_path='export PATH=$DEFAULT_PATH'

# Load Java on OS X
export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Home/
