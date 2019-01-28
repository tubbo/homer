#!/bin/bash
#
# Install Homer on the system. Note that this is _not_ a ZSH script,
# because ZSH may not actually be on the system yet. We can be pretty
# sure that Bash will be there, though, so that's why this script is
# written in Bash instead of ZSH.

if [[ $(uname) == 'Darwin' ]]; then
  mktmp="mktemp"
else
  mktmp="mktmp"
fi

# Find latest released version from GitHub API
repo="https://api.github.com/repos/tubbo/homer/releases/latest"
version=$(curl --silent "$repo" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
tmpdir=$($mktmp -d)
sourcedir="homer-${version:1}"
filename="homer-$version.tar.gz"

pushd "$tmpdir" > /dev/null 2>&1

# Ensure source code is in place
if [ -f "$filename" ]; then
  echo "Using cached version of Homer on disk: $filename"
else
  echo "Downloading Homer $version from GitHub..."
  curl -sL "https://github.com/tubbo/homer/archive/$version.tar.gz" -o "$filename"
fi

# Extract source code from tarball
tar -zxf "$filename"

# Install homer from source to /usr/local and capture exit code
pushd "$sourcedir" > /dev/null 2>&1
echo "Installing Homer..."
sudo make install
code=$?

# Print whether Homer was installed or not
if [[ "$code" == 0 ]]; then
  echo "Homer $version has been installed!"
  echo "Get started by running \`homer init [REPO]\`"
  echo "Or, run \`homer\` to see the full list of commands"
else
  echo "Error installing Homer"
fi

# Clean up the source directory
popd > /dev/null 2>&1
popd > /dev/null 2>&1
rm -rf "$tmpdir"

exit $code
