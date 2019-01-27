---
title: homer
layout: default
---

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
$ homer init -c https://github.com/your/home-dir.git
```

After these commands are run, your home directory will be set up for use
with Homer!

## Usage

To learn how to use Homer, check out the [README][] or run `man homer`
to view command-line documentation.

[README]: https://github.com/tubbo/homer#homer
