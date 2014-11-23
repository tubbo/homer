# Change package-installed Ruby on demand
source /usr/local/opt/chruby/share/chruby/chruby.sh

# Configure the ~/.rubies directory to store Ruby versions.
RUBIES=(
  $HOME/.rubies/*
)

# Enable auto-switching of Ruby on `cd`.
source /usr/local/opt/chruby/share/chruby/auto.sh

if [[ -e "$HOME/.rubies/ruby-1.8.7-p374/" ]]; then
  # So we can actually compile Ruby 1.8
  export CPPFLAGS=-I/opt/X11/include
fi
