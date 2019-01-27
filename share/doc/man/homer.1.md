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

Initialize your home directory as a new repo:

```
homer init
```

Or, clone an existing home directory repo:


```
homer init -c https://github.com/me/home.git
```

You can now save dotfiles to the repo:

```
homer save .vimrc -m "Removed vim-rails"
```

Or, sync with your Git repo if you made changes elsewhere:

```
homer update
```

Homer can even upgrade itself using the latest GitHub release:

```
homer upgrade
```

### Shell Plugins

Homer also provides an easy way to manage ZSH plugins with Antigen.
These plugins are automatically installed when you `init` your home
directory on a new machine.

```
homer plugin zsh-users/zsh-syntax-highlighting
```

You can also remove shell plugins from the manifest:

```
homer plugin zsh-users/zsh-syntax-highlighting -r
```

Homer manages an `~/etc/aliases` file that includes your shell aliases.
To add one, run the following command:

```
homer alias gc 'git commit'
```

Or, forget an alias:

```
homer alias gc -r
```

**NOTE:** The shell will need to be reloaded in order for alias changes
          to take effect.

### User Scripts

Homer establishes a `~/bin` directory for useful scripts that you might
need access to as commands. This directory is added to `$PATH` so that
its executable contents can be used as commands across the system.

Adding a new command

```
homer script path/to/your/script/find-and-replace-in-project
```

You can now use the script as if it was a command:

```
find-and-replace-in-project
```

To remove the script from `~/bin`:

```
homer script find-and-replace-in-project -r
```

## GENERATED FILES

The following files are generated when you run the `homer init`
command...

*~/bin:* User scripts directory. Added to your `$PATH` automatically.

*~/etc/profile.d/:* User configs directory

*~/etc/plugins.zsh:* Plugins configuration

*~/etc/aliases.zsh:* User aliases configuration


## AUTHOR

Tom Scott <http://psychedeli.ca>

## SEE ALSO

antigen(1)
zsh(1)
git(1)
