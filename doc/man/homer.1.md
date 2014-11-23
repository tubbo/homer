# homer 1 "Nov 2014" homer "User Manuals"

## SYNOPSIS

`homer` COMMAND [ARGUMENTS]

## DESCRIPTION

Homer is a command-line utility to manage your shell's home directory.

For more information, check out:

https://github.com/tubbo/homer#readme

## ARGUMENTS

*COMMAND*
	The command you wish to run.

*ARGUMENTS*
	Arguments for said command.

## COMMANDS

- init
- save
- update
- load

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
homer plugin install zsh-users/zsh-syntax-highlighting
```

Remove shell plugins:

```
homer plugin uninstall zsh-users/zsh-syntax-highlighting
```

Save an alias for later use:

```
homer alias gc 'git commit'
gc -m "wow this is cool"
```

Forget an alias:

```
homer alias --delete gc
```

Copy useful scripts to your `$PATH`:

```
homer script bin/find-and-replace-in-project
find-and-replace-in-project
```

## FILES

*~/etc*
	Config directory

*~/etc/plugins*
  Plugins configuration

*~/etc/aliases*
  User aliases configuration

*~/bin*
  Binaries directory

## AUTHOR

Tom Scott <tubbo@psychedeli.ca> <http://psychedeli.ca>

## SEE ALSO

antigen(1)
