#!/bin/bash
#
# Install Homer on the system. Note that this is _not_ a ZSH script,
# because ZSH may not actually be on the system yet. We can be pretty
# sure that Bash will be there, though, so that's why this script is
# written in Bash instead of ZSH.


# Find latest released version from GitHub API
repo="https://api.github.com/repos/tubbo/homer/releases/latest"
version=$(curl --silent "$repo" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
tmpfile="/tmp/homer-$version.tar.gz"

# Download release source code from GitHub
curl "https://github.com/tubbo/homer/archive/$version.tar.gz" -o "$tmpfile"

# Extract the source code to /tmp
tar -zxvf "$tmpfile" "/tmp/homer-$version"

# Install Homer from source
pushd "/tmp/homer-$version"
make && make install && echo "Installed Homer v$version"
popd
