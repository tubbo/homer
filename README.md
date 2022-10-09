# Homer

![Homer Thinking](https://github.com/tubbo/homer/raw/master/docs/homer-thinking.gif)

Homer is a home directory manager for your shell. Using [Git][git], it
tracks changes in your home directory configuration from anywhere on
your machine. Its goal is to make shell portability a breeze, by simplifying
the process for synchronizing shell configuration between multiple active machines
or replacement computers.

![...but why?](https://media.tenor.com/jGgmfDOxmuMAAAAC/ryan-reynolds-but-why.gif)

As computer lifespans get shorter and shorter, and we've begun treating remote
computers [more like cattle than pets][cattle], moving a bunch of configuration
files around from machine to machine is still error-prone and a very manual
process. Most developers who "live in the shell" have their own handrolled
solution for this problem, but this doesn't scale when you're rapidly moving
between laptops (either because you're moving jobs or just upgrading), trying
to have the same experience on multiple active computers, or you're SSHing
into remote machines and are constantly finding yourself doing "muscle memory"
things that aren't configured on the server. **If you have found yourself doing
this on more than one occasion, Homer was built for you.**

## How It Works

Homer is effectively a Git repository manager that makes cloning a repository
into your home directory easier, as well as setting that repository up with
some useful conventions for maintainability and security. It's comparable with
tools such as [GNU Stow][stow], but differs in that instead of symlinking files
between a managed directory and their actual location, Homer puts the Git repo
in your home directory itself. This allows tracking any file in `~` and makes
synchronizing between running machines a painless (and possibly automatic)
process. It also enables tracking files that may not play nice with symlinks,
as there are quite a few applications which will not treat links the same as
regular files, in addition to the myriad of permissions issues that can be
encountered using this approach.

Using a few "tricks" in Git's mechanics that aren't exactly intuitive to
most developers (nor is it useful knowledge for most workflows), Homer allows
tracking any file in the home directory. To do so, it initializes a Git repo
in `$HOME`, but adds a `.gitignore` file at the root that ignores all files by
default. This makes sure that you're only adding the files you actually want to
track, rather than running `git add .` and accidentally committing all of the
temporary files and data volumes in your home dir.

This is all well and good for a single machine, but what happens when you
move between them? A simple `git clone` into your existing home directory
isn't going to work, because there are already files in there. Homer can solve
this problem by "bootstrapping" your machine with the clone of a Git repo,
as well as running useful scripts to install software and set up tooling on
your new machine or user account. By cloning into a temporary directory and
manipulating the worktree locations directly, Homer can checkout all of the
files in your default branch without disturbing any of the files that already
exist. This not only allows for setup on a brand new machine, but can also be
used for "normalizing" your existing user account configuration. By running
`homer bootstrap` in a working user account, you can clone your repository
in and begin adding any additional files that may exist and/or reconcile the
differences in configuration between machines. When everything is done, you can
`homer update` and make sure those changes work everywhere else. This bootstrap
process makes shell portability much easier to work out, as you don't have to
`scp` files between machines and hope everything works, you can test things
locally and only pull down on a remote machine when you're confident that it
won't brick your shell account or something.
 
## Features

- Syncs home directory configuration with a Git repository
- Manages shell aliases and custom shell scripts
- Manages OS packages and custom package repositories
- Exposes useful attributes and contains a small CLI plugin API that
  allows for hooking into Homer and adding your own commands.

## Installation

Homer is available on [Homebrew][brew] for both Linux and macOS systems:

```bash
$ brew tap tubbo/homebrew-tap
$ brew install homer
```

For Windows systems, 

You can also choose to download a release directly from the [GitHub Releases][]
page:

```bash
curl -sLO https://github.com/tubbo/homer/releases/download/latest/homer-windows.tar.gz
```

If you have the [Rust][] toolchain installed, you can also opt to install Homer
from its [Cargo][] crate:

```bash
$ cargo install homer
```

Finally, to install an unreleased version, you can build from source:

```bash
$ git clone https://github.com/tubbo/homer.git
$ cd homer
$ cargo install
```

For more build options when installing from source, see the **Development**
section.

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
directory with a Git repository. As stated above, it's also used to initialize
and synchronize this repository across machines so that your configuration
can stay up-to-date when you move around computers or replace them. 

### Adding and Removing Files

When you initialize a new Homer repository, your entire home directory will be
ignored by default. In order to begin tracking files, you'll need to add them
manually, either by using `git` in the home directory or with `homer`'s
convenience commands.

You can add files that are currently untracked from anywhere on your machine
with the `homer add` command:

```bash
$ homer add ~/.vimrc -m "add vim config"
$ homer add ~/.config -m "add xdg configs"
$ homer add ~/.zshrc -m "add zsh config"
$ homer add ~/.tmux.conf -m "add tmux config"
```

This will begin tracking the file at `~/.vimrc` in your home directory
repo. A commit will be added using the message in `-m`, and you can run
`homer update` to sync with the remote at any time.

If you wish to stop tracking a given configuration file, run `homer rm`
to delete it from the repo:

```bash
$ homer rm ~/.config/private -m "remove private config"
```

This removes the directory or file from your repo (but retains it in your
home directory) and stops tracking it. When no `-m` is given for a
message, the message is derived from the action, command, and filename.

You can also pass `--clean` to remove the file in addition to untracking it. 

#### Git Operations

Since Homer is using [libgit2][] bindings instead of actually passing anything
to the `git` binaries, it doesn't support any advanced (or future) "porcelain"
features such as `git add -p` or `git commit --squash`. If you want to do
anything out of the ordinary with your home directory Git repo, you'll need to
`cd` in and perform the operations yourself.

The `homer add` command is essentially "syntax sugar" for the following Git CLI
operations:


```bash
$ git add -f ~/.vimrc
$ git commit ~/.vimrc -m "add vim config"
```

Likewise, the `homer rm` command is analogous to this:

```bash
# if you want a `--clean` style experience, remove the `--cached` flag below:
$ git rm --cached ~/.config/private
$ git commit ~/.config/private -m "remove private config"
```

Given that `git`'s porcelain tooling is subject to change, the way Homer has
implemented these features and the way Git implements them may change a bit,
which is why you can always go into your home directory and make any required
changes yourself.

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
local changes that have not been uploaded yet. Changes that have not been
committed will be stashed temporarily until the pull/push operations complete. 

## Development

Homer is written entirely in [Rust][], and uses [Cargo][] for most package and
build management. As such, you'll need the Rust toolchain (among other things)
to build this package.

You can install a development environment on macOS or Linux (if you're running
Homebrew Linux) by running these commands:

```bash
$ git clone https://github.com/tubbo/homer.git
$ cd homer
$ brew bundle
````

This should install the Rust toolchain, including `cargo`. Make sure it all
works by running type checks:

```bash
cargo check
```

If everything went well, you can run tests with the following command:

```bash
$ cargo test
```

Or, build `homer` locally in "debug" mode:

```bash
$ cargo build
```

The program will be located in `target/debug`.

Release versions are typically built in [CI][] automatically, and distributed
over [GitHub][GitHub Releases] and [Homebrew][], but you can also build for the
release target manually by running:

```bash
$ cargo build --release
```

The program will be located in `target/release`.

Finally, if you want to clean everything off your system that was built, run:

```bash
$ cargo clean
```

### License

Homer uses the MIT License, as described below:

```
The MIT License (MIT)

Copyright (c) 2014-2022 Tom Scott

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
[homebrew]: http://brew.sh
[ci]: https://github.com/tubbo/homer/actions
[gitHub releases]: https://github.com/tubbo/homer/releases
[rust]: https://www.rust-lang.org/
[cargo]: https://doc.rust-lang.org/cargo/
[cattle]: http://cloudscaling.com/blog/cloud-computing/the-history-of-pets-vs-cattle/
[libgit2]: https://libgit2.org/