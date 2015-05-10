# homer 1 "Nov 2014" homer "User Manuals"

## NAME

homer - your home directory manager

## SYNOPSIS

`homer` COMMAND [ARGUMENTS]

## DESCRIPTION

Homer is a command-line utility to manage your shell's home directory.
It turns your entire home directory into a Git repo so you can
version control non-sensitive configuration and data and synchronize
them across machines. It also includes provisions for installing custom
shell scripts, aliases and hooks for package management tooling. Homer
is designed around the Unix philosophy, and stays out of your way as
much as possible. It is written entirely in ZSH shell script.

For more information, check out:

https://github.com/tubbo/homer#readme

## ARGUMENTS

*COMMAND*
  The command you wish to run.

*ARGUMENTS*
  Arguments for said command.

## EXAMPLES

Save a dotfile:

```
homer save .vimrc -m "Removed vim-rails"
```

Sync with your Git repo:

```
homer update
```

Install shell plugins:

```
homer plugin zsh-users/zsh-syntax-highlighting
```

Remove shell plugins:

```
homer plugin zsh-users/zsh-syntax-highlighting -r
```

Save an alias for later use:

```
homer alias gc 'git commit'
```

Forget an alias:

```
homer alias gc -r
```

Copy useful scripts to your `$PATH`:

```
homer script bin/find-and-replace-in-project
find-and-replace-in-project
```

And remove them:

```
homer script find-and-replace-in-project -r
```

Homer can even upgrade itself:

```
homer upgrade
```

And update its codebase with Homebrew:

```
homer upgrade -p
```

It can also manage your Homebrew packages...

```
homer brew tap tubbo/tap
```

Taps...

```
homer brew package vim
```

And casks...

```
homer brew cask hipchat
```

Or you can pre-define a list and just run this command
to install everything:

```
homer brew
```

## GENERATED FILES

The following files are generated when you run the `homer init`
command...

*~/bin:* User scripts directory. Added to your `$PATH` automatically.

*~/etc/profile.d/:* User configs directory

*~/etc/plugins.zsh:* Plugins configuration

*~/etc/aliases.zsh:* User aliases configuration

*~/etc/brew/casks:* Homebrew casks to install

*~/etc/brew/packages:* Homebrew packages to install

*~/etc/brew/taps:* Homebrew taps to install


## AUTHOR

Tom Scott <http://psychedeli.ca>

## SEE ALSO

antigen(1)
zsh(1)
git(1)
