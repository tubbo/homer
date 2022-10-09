---
title: homer
layout: default
---

Homer is a home directory manager for your shell. Using **Git** under the hood,
it tracks changes in your home directory configuration from anywhere on your
machine. Its goal is to make shell portability a breeze, by simplifying the
process for synchronizing shell configuration between multiple active machines
or replacement computers.

**[Would you like to learn more?][readme]**

## Installation

Homer can be installed on macOS and Linux using **Homebrew**:

```bash
brew tap tubbo/tap
brew install homer
```

On Windows? [Download the latest release installer][msi].

## Getting Started

If you're new to all this, set up your home directory repo by running the
following command:

```bash
$ homer init
```

For seasoned veterans, you can clone your home directory repo and run
bootstrap scripts with this command:

```bash
$ homer bootstrap https://url.to/your/home/repo.git
```

## Bootstrap Scripts

`homer bootstrap` looks for a script in your home directory named `~/bin/
bootstrap.sh`. If this file is found, Homer will execute the script using the
shell specified with `$SHELL` in your command-line (this is usually set by your
system in the environment by default). This script is user-provided and can be
used to set up the system with all kinds of stuff, such as:

- Installing packages
- Pulling down untracked secrets
- Configuring system settings
- Applying software packages

...and a whole lot more!

[README]: https://github.com/tubbo/homer#homer
[msi]: https://github.com/tubbo/homer/releases/download/latest/homer.msi
