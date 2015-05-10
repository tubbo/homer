# Homer

[![Build Status](https://travis-ci.org/tubbo/homer.svg?branch=master)][ci]

Homer is a home directory manager for your shell. Using [Git][git], it
tracks changes in your home directory configuration from anywhere on
your machine. Its goal is to uncover the IDE-like possibilities of the
shell and make such features more approachable to newer users, while
still retaining its usefulness to power users.

Homer is an opinionated, but minimal, framework. While most of what
it assumes about your environment is strongly enforced across the
framework, it attempts to assume very little about your system, instead
allowing you to customize your shell the way you see fit. In many ways,
Homer is really meant to just get rid of all the boilerplate code one
would need to have a really stellar shell environment.

## How It Works

Homer is effectively a Git repo and shell manager that can be accessed
from anywhere on the machine. It's written entirely in ZSH shell script
in a way that's both performant and highly accurate. Homer is really
nothing more than a set of conventions, a few shell scripts to make
things easier, and some useful/sane defaults for ZSH. All of Homer's
components are simply tools that wrap a Git repository, usually
performing a command in the process (like adding an alias or copying a
whole script) which involves changing a file in the home directory.

Homer is very similar to tools like [GNU Stow][stow], its main
difference is that instead of keeping a directory separate from
`$HOME` and symlinking the necessary files over from some
version-controlled directory when asked, Homer simply uses the home
directory as a Git repo and ignores any files it doesn't explicitly
track. It also provides a few more services than Stow,
such as alias and plugin management. Homer is not just for keeping dot
files secure, it's a tool for managing all of the files in your home
directory you wish to keep with Git.

## Features

- Syncs home directory configuration with a Git repository
- Manages shell aliases and custom shell scripts
- Manages OS packages and custom package repositories
- Exposes useful attributes and contains a small CLI plugin API that
  allows for hooking into Homer and adding your own commands.

## Installation

There are a number of ways to install Homer...

### From a Package Manager

As a package, Homer is currently only available on [Homebrew][brew]:

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
- bats (only if you're developing on the project)

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

## Usage

Homer can save your dotfiles.

```bash
$ homer save .vimrc -m "Removed vim-rails"
```

Homer can sync with your Git repo.

```bash
$ homer update
```

(To update Homer itself, use Homebrew: `brew upgrade homer`)

Homer can install shell plugins.

```bash
$ homer plugin install zsh-users/zsh-syntax-highlighting
```

As well as remove them.

```bash
$ homer plugin uninstall zsh-users/zsh-syntax-highlighting
```

Homer can add aliases and save them for later use.

```bash
$ homer alias gc 'git commit'
$ gc -m "wow this is cool"
```

It can also delete them.

```bash
$ homer alias -d gc
```

Homer can copy useful scripts to your `$PATH`.

```bash
$ homer script bin/find-and-replace-in-project
$ find-and-replace-in-project
```

All of the aforementioned commands include automatic committing to your
home dir's repo, so you never lose your place. Homer isn't the smartest
guy in the world, but he gets the job done. He stays out of your way and
if you want to change your shell around, he makes it easy.

### Conventions

Homer establishes a number of conventions on your home directory. It
uses the **bin/** directory to store user-made scripts which can be made
available in the path. It creates an **etc/** directory and uses that to
store files such as **etc/plugins.zsh** for defining shell plugins and
**etc/aliases.zsh** for storing shell aliases you wish to recall later.
Note that the aforementioned files should not be edited manually, the
`homer alias` and `homer plugin` tools are meant to manage the files for
you.

## Development

Homer is written entirely in ZSH shell script. It uses [BATS][bats] to
run its tests. All contributions must include tests.

To run tests, execute the following command at the root of the project
directory:

```bash
$ make test
```

To generate Man documentation:

```bash
$ make man
```

You can also use the Makefile to generate a command:

```bash
$ make command NAME=test
```

This will generate `bin/homer-test` and `share/doc/commands/test.txt`
with given templates.

### License

Homer uses the MIT License, as described below:

```
The MIT License (MIT)

Copyright (c) 2014 Tom Scott

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
