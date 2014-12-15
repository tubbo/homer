# homer 1 "Nov 2014" homer "User Manuals"

## NAME

homer - your home directory manager

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

## GENERATED FILES


*~/bin:* User scripts directory. Added to your `$PATH` automatically.

*~/etc/profile.d/:* User configs directory

*~/etc/plugins.zsh:* Plugins configuration

*~/etc/aliases.zsh:* User aliases configuration


## AUTHOR

Tom Scott <http://psychedeli.ca>

## SEE ALSO

antigen(1)
