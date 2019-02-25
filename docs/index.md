---
title: homer
layout: default
---

Homer is a home directory manager for your shell. Using Git, it
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

The only requirement to run Homer is that you have the [Z Shell][zsh]
installed. Homer is written entirely in ZSH shell script, and works best
in a ZSH environment since it takes advantage of a number of its
features.

## Features

- **Conventional Directories:** Homer establishes a number of
  directories in your home directory, like `~/bin` and `~/etc`, for
  storing executable scripts and shell configuration. Drop new `.zsh` files in
  `~/etc/profile.d` to have them apply automatically when your shell is
  loaded. Homer ensures that `~/bin` is in your `$PATH` so the
  executable scripts in that directory are always available as extra
  commands in your shell.
- **Dotfiles:** Save your configuration files directly where they need
  to be in your home directory from anywhere on the system. No need to
  mess around with symlink.
- **Aliases:** Remembering long commands can be tough, and shell aliases
  are a built-in solution to that problem. Homer makes it easier to
  manage aliases from the `~/etc/aliases.zsh` directory, loaded in your
  shell automatically.
- **ZSH Plugins:** One benefit to using ZSH is the vast amount of
  plugins that can be installed using Antigen, but managing these
  plugins can be somewhat difficult. Homer comes bundled with Antigen
  and manages the plugins you wish to install from your `~/etc/plugins.zsh`
  manifest file.
- **Idempotency:** Homer can self-update, sync with a remote repository,
  and cleanly rehydrate the contents of a cloned repository into your home
  directory upon new installations.

## Installation

Install with our handy-dandy script:

```bash
$ curl -o- -L https://tubbo.github.io/homer/install.sh | bash
```

If you're on macOS, you can also install with Homebrew:

```bash
$ brew tap tubbo/homebrew-tap
$ brew install homer
```

## Setup

Once Homer is installed, you can use it to either create a new
repository for persisting your configuration, or you can pull down an
existing repository and extract it on top of the existing home directory
on your machine.

To create a new home directory repo:

```bash
$ homer init
```

Otherwise, provide the URL to your existing home directory repo:

```bash
$ homer init https://github.com/your/home-dir.git
```

After these commands are run, your home directory will be set up for use
with Homer!

## Usage

To learn how to use Homer, check out the [README][], run `man homer`
to view command-line documentation, or view the manpages online:

- [homer(1)][]
- [edit(1)][]
- [page(1)][]

[README]: https://github.com/tubbo/homer#homer
[homer(1)]: manual/homer.1.html
[edit(1)]: manual/edit.1.html
[page(1)]: manual/page.1.html
