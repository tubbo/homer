# Homer

[![Test Status](https://github.com/tubbo/homer/workflows/Tests/badge.svg)][ci]
[![Build Status](https://github.com/tubbo/homer/workflows/Build/badge.svg)][ci]
[![Publish Status](https://github.com/tubbo/homer/workflows/Publish/badge.svg)][ci]

![Homer Thinking](https://github.com/tubbo/homer/raw/master/docs/homer-thinking.gif)

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

Download a binary of Homer by visiting the [GitHub Releases][] page.

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

Homer is written in [Rust][], so make sure you have the toolchain all
set up before cloning this repo.

Once they're all installed, run the following commands to install to
`/usr/local`...

```bash
$ git clone https://github.com/tubbo/homer.git
$ cd homer
$ cargo install
```

## Setup

When the binary is installed, run the setup command:

```bash
$ homer init
```

This will create a Git repo in your home directory, and add a `~/.gitignore`
file to control it.

If you already have a home directory repo that was initialized using
Homer, you can copy it down to your machine with the following command:

```bash
$ homer bootstrap https://url.to/your/home/directory/repo.git
```

This will clone the Git repo at the URL provided to `/tmp/homer` without
actually checking out a working copy. After copying the `.git` directory
(the actual data contents of the repo) to your home directory, it will
checkout the worktree that `~/.git` is pointing to in-place within your
home directory. This will effectively load in your Git-tracked files
without disturbing any of the other files that currently exist in your
home dir.

## Usage

Homer is primarily used to track files which are located in your home
directory to your Git repository. You can add files that are currently
untracked with the `homer add` command:

```bash
$ homer add .vimrc -m "Removed vim-rails"
```

This will begin tracking the file at `~/.vimrc` in your home directory
repo. A commit will be added using the message in `-m`, and you can run
`homer update` to sync with the remote at any time.

If you wish to stop tracking a given configuration file, run `homer rm`
to delete it from the repo:

```bash
$ homer rm .vimrc
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

This will not only `git pull` changes from the remote, but also `git push`
local changes that have not been uploaded yet.

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

Homer is written entirely in [Rust][], and uses [Cargo][] for most package and
build management.

To run tests:

```bash
$ cargo test
```

To build the app locally in debug mode:

```bash
$ cargo build
```

To build a release version:

```bash
$ cargo build --release
```

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
[GitHub Release]: https://github.com/tubbo/homer/releases
