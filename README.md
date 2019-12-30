# Homer

[![Test Status](https://github.com/tubbo/homer/workflows/Tests/badge.svg)][ci]
[![Build Status](https://github.com/tubbo/homer/workflows/Build/badge.svg)][ci]
[![Publish Status](https://github.com/tubbo/homer/workflows/Publish/badge.svg)][ci]

![Homer Thinking](http://i.giphy.com/JDHMwstcLRza0.gif)

Homer is a home directory manager for your shell. Using [Git][git], it
tracks changes in your home directory configuration from anywhere on
your machine. Its goal is to uncover the IDE-like possibilities of the
shell and make such features more approachable to newer users, while
still retaining its usefulness to power users.

Homer is an opinionated, but minimal, framework. While most of what
it assumes about your environment is strongly enforced across the
framework, it attempts to assume little about your system, instead
allowing you to customize your shell the way you see fit. Homer's main
philosophy is that having a stellar shell configuration should be
much easier than it is today.

## How It Works

Homer is effectively a Git repo and shell extension manager that is accessible
from anywhere on the machine. It's written entirely in [ZSH][] shell
script, but you don't have to use ZSH to gain its benefits. Homer is actually
nothing more than a set of conventions, some shell scripts to make
complex tasks easier, and some useful/sane defaults for ZSH. Homer's
components are tools that wrap a Git repository and your ZSH
configuration.

Homer is comparable with tools like [GNU Stow][stow], its main
difference is that instead of keeping a directory separate from
`$HOME` and symlinking the necessary files over from some
version-controlled directory when asked, Homer uses the home
directory as a Git repository and ignores any files it doesn't explicitly
track. It also provides ZSH-specific alias and plugin management, which
Stow as a more generalized system does not do. Homer is essentially a tool for
managing any file in your home directory you wish to keep with Git.

## Features

- Syncs home directory configuration with a Git repository
- Manages shell aliases and custom shell scripts
- Manages OS packages and custom package repositories
- Exposes useful attributes and contains a small CLI plugin API that
  allows for hooking into Homer and adding your own commands.

## Installation

The easiest way to install Homer is with the one-liner install script:

```bash
$ curl -o- -L https://homer.psychedeli.ca/install.sh | bash
```

It's a good practice to always [view the source code][installer] before
running a command like this, but if you're busy, here's a short
description of what the installer script does:

1. Downloads the latest `.tar.gz` release of Homer
2. Extracts the source code to a directory in `/tmp`
3. Runs `sudo make` in the source code directory, this will require you
   to type in your root password
4. Removes all files in the `/tmp` directory created by the installer.

### From a Package Manager

As a package, Homer is available on [Homebrew][brew]:

```bash
$ brew tap tubbo/homebrew-tap
$ brew install homer
```

You can also install the edge version of Homer, which is the latest
commit of 'master' branch, by applying the **--HEAD** switch:

```bash
$ brew install homer --HEAD
```

### From Source

Before installing from source, make sure you have the following hard
dependencies installed:

- zsh
- antigen
- keychain
- bats (if you're developing on the project)

Once they're all installed, run the following commands to install to
`/usr/local`...

```bash
$ git clone https://github.com/tubbo/homer.git
$ cd homer
$ make && sudo make install
```

When its installed, run the setup command:

```bash
$ homer init
```

This will create a Git repo in your home directory, add
a `~/.gitignore` file to control it, and some
default ZSH configuration.

If you already have a home directory repo that was initialized using
Homer, you can copy it down to your machine with the following command:

```bash
$ homer init https://url.to/your/home/directory/repo.git
```

This will clone the Git repo at the URL provided to `/tmp/homer` without
actually checking out a working copy. After copying the `.git` directory
(the actual data contents of the repo) to your home directory, it will
run `git reset --hard HEAD` to "rehydrate" all the files of the working
copy in the home directory rather than in the place it was checked out.
This is to ensure that any overwritten files will have a diff to show
you what changed, and none of your files that currently exist in the
home directory will be accidentally deleted.

## Usage

Homer is primarily used to track files which are located in your home
directory to your Git repository. You can add files that are currently
untracked with the `homer save` command:

```bash
$ homer save .vimrc -m "Removed vim-rails"
```

This will begin tracking the file at `~/.vimrc` in your home directory
repo. A commit will be added using the message in `-m`, and you can run
`homer update` to sync with the remote at any time.

If you wish to stop tracking a given configuration file, run `homer
save` with the `-r` flag:

```bash
$ homer save -r .vimrc
```

This removes the `~/.vimrc` file from your repo (but retains it in your
home directory) and stops tracking it. When no `-m` is given for a
message, the message is derived from the action, command, and filename.

### Idempotency

Homer is designed to keep your local machine's configuration in sync
with the configuration that may be stored on a remote Git repository.
This could have changes that are not yet on your machine, and Homer
can pull those changes down, cleanly, without affecting any files that
you may have locally edited.

To update the current home directory with the remote:

```bash
$ homer update
```

You can also update Homer itself, which is basically re-running the
installer script. To do so, run:

```bash
$ homer upgrade
```

### Plugins

Homer provides an easy way to manage ZSH plugins with [Antigen][].
These plugins are automatically installed when you `init` your home
directory on a new machine. Antigen is installed automatically upon
initialization if it's not already installed. The plugin manifest can be
found in `~/etc/plugins.zsh`.

To install a new plugin:

```bash
$ homer plugin zsh-users/zsh-syntax-highlighting
```

As well as remove them.

```bash
$ homer plugin zsh-users/zsh-syntax-highlighting -r
```

### Aliases

Homer can add aliases and save them for later use. These aliases are
stored in `~/etc/aliases.zsh`, and tracked by Git so they can be shared
in your home directory repository.

To add a new alias:

```bash
$ homer alias gc 'git commit'
```

Reload your shell, and you can now use `gc` as an alias to `git commit`:

```bash
$ gc -m "wow this is cool"
```

To delete an alias:

```bash
$ homer alias -d gc
```

### User Scripts

If you write a useful shell script or executable, Homer can copy this
file to a directory in your `$PATH`. Homer uses the `~/bin` directory
for this purpose, and keeps files in this directory checked in to Git so
you can share them in your home directory repo. Upon initialization,
Homer will also `chmod +x` this entire directory to ensure that files
created within it will default to be executable by the current user.

```bash
$ homer script bin/find-and-replace-in-project
$ find-and-replace-in-project
```

You can also remove commands from this directory:

```bash
$ homer script bin/find-and-replace-in-project -r
```

### Text Editing and Paging

Homer uses the `$EDITOR` and `$PAGER` variables as the backbone for the
`edit` and `page` (or `e` and `v`) commands used to edit and view text
files, respectively. Text editing and viewing files with a page are two
of the most common tasks performed within the shell, and Homer helps
integrate whatever editor you choose to use seamlessly within your shell
environment.

To edit text with your `$EDITOR`, run:

```bash
$ edit some/file.txt
```

You can also view files with the `$PAGER` by running:

```bash
$ page /var/log/system.log
```

The `$EDITOR` is set to `vi` by default, and the `$PAGER` is set to
`less`, but you can change these values in your **~/.zshenv**:

```bash
export EDITOR='vim'
export PAGER='less -r'
```

### Conventions

Homer establishes useful conventions on your home directory. It
uses the **~/bin/** directory to store user-made scripts which are
available in the `$PATH`. It creates an **~/etc/** directory and uses that to
store files such as **~/etc/plugins.zsh** for defining shell plugins and
**~/etc/aliases.zsh** for storing shell aliases you wish to recall later.
Note that you should not edit the manifest files mentioned above manually, the
`homer alias` and `homer plugin` tools should manage the files for
you. Place any ZSH code you wish to load when the shell launches
in "initializer" files within **~/etc/profile.d**, keeping **~/.zshrc** and
**~/.zshenv** clear.

As well as creating these initial files, it also runs `git init` in your
home directory, effectively making the entire thing a Git repository. In order
to prevent massive repo sizes and checking in unsafe credentials,
Homer does not initially add any files to this repo, except for the ones
it generates. One of these generated files is a `.gitignore`, which ignores all
files in the home directory by default. To add files to the repo, you need to use
`homer save` or run `git add -f` in your home directory.

## Development

Homer is written entirely in [ZSH][] shell script. It uses [BATS][bats] to
run its tests, and a Makefile is provided to run the tests as well as
build/install the project.

To run tests:

```bash
$ make test
```

You can also use the Makefile to generate a new command:

```bash
$ make command NAME=foo
```

This will generate `bin/homer-foo`, `share/doc/homer/foo.txt`, and
`test/homer-foo-test.bats` with given templates.

The Makefile is also used to create releases. Change the version in
`share/homer/VERSION` as well as the `VERSION=` environment variable,
run `make` to build the docs and signed package files, then run
`make release` to tag with Git and push to GitHub.

### License

Homer uses the MIT License, as described below:

```
The MIT License (MIT)

Copyright (c) 2014-2019 Tom Scott

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
```

[git]: http://git-scm.com
[brew]: http://brew.sh
[bats]: https://github.com/sstephenson/bats
[stow]: http://www.gnu.org/software/stow/
[ci]: https://github.com/tubbo/homer/actions
[Antigen]: https://github.com/zsh-users/antigen
[ZSH]: http://zsh.sourceforge.net/
[installer]: https://github.com/tubbo/homer/blob/master/docs/install.sh
