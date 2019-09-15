page(1) - Open files for viewing and reading in realtime
========================================================

## SYNOPSIS

`page` [ARGUMENTS]

## DESCRIPTION

The **page** command is used to open files for viewing using your
configured pager program, such as `less`. It's a quick time-saver that
uses the **$PAGER** variable in your shell for viewing files quickly, or
in real-time as they are updated. All arguments passed into this utility
will be passed onward to the configured shell pager program.

**page** is provided by **homer**. For more information, check out:

https://github.com/tubbo/homer#readme

## ARGUMENTS

*ARGUMENTS*
  Arguments passed to the pager.

## EXAMPLES

Open a file with your pager:

```
page /var/log/system.log
```

## CONFIGURATION

To configure which program is opened when the `page` command is run, set
the **$PAGER** variable in your shell like so:

```
export PAGER="less -r"
```

(Homer will do this for you in `~/.zshenv`)

## AUTHOR

Tom Scott <http://psychedeli.ca>

## SEE ALSO

homer(1)
edit(1)
