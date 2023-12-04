# homer 1 "May 2020" Homer "User Manual"

## NAME

edit - Open files for editing and manipulating

## SYNOPSIS

`edit` [*ARGUMENTS*]

## DESCRIPTION

The **edit** utility is used to open and edit files using your
configured editor. It's a quick time-saver that uses the configured
**$EDITOR** in your shell for editing files. All arguments passed into
this utility will be passed onward to the configured shell editor
program.

**edit** is provided by **homer**. For more information, check out:

https://github.com/tubbo/homer#readme

## ARGUMENTS

*ARGUMENTS*
: Arguments passed to the editor.

## EXAMPLES

Open a file with your editor:

```
edit path/to/my/file.txt
```

## CONFIGURATION

To configure which program is opened when the `edit` command is run, set
the **$EDITOR** variable in your shell like so:

```
export EDITOR=vim
```

(Homer will do this for you in `~/.zshenv`)

## AUTHOR

Tom Scott <http://psychedeli.ca>

## SEE ALSO

[homer(1)](home.1.md) [page(1)](page.1.md)
