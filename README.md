# Homer

[![Build Status](https://travis-ci.org/tubbo/homer.svg?branch=master)][ci]

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
much easier.

## How It Works

Homer is effectively a Git repo and shell manager that is accessible
from anywhere on the machine. It's written entirely in ZSH shell script
in a way that's both performant and highly accurate. Homer is actually
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
$ make
```

When its installed, run the setup command:

```bash
$ homer init
```

This will create a Git repo in your home directory, add
a `~/.gitignore` file to control it, and some
default ZSH configuration. You can also pass the `-c REPO_URL`
option to clone an existing dotfiles repo rather than creating
a new one. It copies your existing home directory to `/tmp/home`,
clones your existing Git repo in your home directory, then merges
the `/tmp/home` directory back into home, wherein you can reset
or commit any changes you wish to remove or keep, respectively.

**Make sure you add any files you wish to keep in your dotfiles repo when homer initializes.**

## Usage

Homer can save your dotfiles.

```bash
$ homer save .vimrc -m "Removed vim-rails"
```

Homer can sync with your Git repo.

```bash
$ homer update
```

(To update Homer itself, run `homer upgrade`)

### Plugins

Homer provides an easy way to manage ZSH plugins with [Antigen][].
These plugins are automatically installed when you `init` your home
directory on a new machine. Antigen is installed automatically upon
initialization if it's not already installed.

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
you can share them in your home directory repo.

```bash
$ homer script bin/find-and-replace-in-project
$ find-and-replace-in-project
```

You can also remove commands from this directory:

```bash
$ homer script bin/find-and-replace-in-project -r
```

### Conventions

Homer establishes useful conventions on your home directory. It
uses the **bin/** directory to store user-made scripts which are
available in the path. It creates an **etc/** directory and uses that to
store files such as **etc/plugins.zsh** for defining shell plugins and
**etc/aliases.zsh** for storing shell aliases you wish to recall later.
Note that you should not edit the manifest files mentioned above manually, the
`homer alias` and `homer plugin` tools should manage the files for
you. Place any ZSH code you wish to load when the shell launches
in initializer files within **etc/profile.d**, keeping **~/.zshrc** and
**~/.zshenv** clear.

As well as creating these initial files, it also runs `git init` in your
home directory, effectively making the entire thing a Git repository. In order
to prevent massive repo sizes and checking in unsafe credentials,
Homer does not initially add any files to this repo, except for the ones
it generates. One of these generated files is a `.gitignore`, which ignores all
files in the home directory by default. To add files to the repo, you need to use
`homer save` or run `git add -f` in your home directory.

## Development

Homer is written entirely in ZSH shell script. It uses [BATS][bats] to
run its tests. All contributions must include tests.

Run tests by performing following command at the root of the project
directory:

```bash
$ make test
```

To generate manpages:

```bash
$ make man
```

You can also use the Makefile to generate a command:

```bash
$ make command NAME=foo
```

This will generate `bin/homer-foo` and `share/doc/commands/foo.txt`
with given templates.

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

Pull requests must pass [CI][ci] before being accepted.

[git]: http://git-scm.com
[brew]: http://brew.sh
[bats]: https://github.com/sstephenson/bats
[stow]: http://www.gnu.org/software/stow/
[ci]: https://travis-ci.org/tubbo/homer
[Antigen]: https://github.com/zsh-users/antigen
