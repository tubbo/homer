# Homer

Homer keeps your home directory tidy and easy to navigate. It
automatically stores content in various folders and can easily sync
hidden-file configuration to a GitHub repository.

## Features

- Sync home directory configuration with GitHub
- Keep music and media files in their respective folders (`~/Music`,
  `~/Movies`, etc.)
- Stores documents in ~/Documents.

## Installation

Install Homer with Homebrew:

```bash
$ brew tap tubbo/brewery
$ brew install homer
```

Or, you can clone this repo and install the bleeding-edge version.

```bash
$ git clone https://github.com/tubbo/homer.git
$ cd homer
$ make install
```

When its installed, run the setup command:

```bash
$ homer init
```

This will turn your home directory into a Git repo and upload its
initial commit to GitHub.

## Usage

Homer can save your dotfiles.

```bash
$ homer save .vimrc -m "Removed vim-rails"
```

Homer can sync with your Git repo.

```bash
$ homer update
```

(To update Homer itself, use Homebrew: `brew upgrade homer`)

Homer can install shell plugins.

```bash
$ homer plugin install zsh-users/zsh-syntax-highlighting
```

As well as remove them.

```bash
$ homer plugin uninstall zsh-users/zsh-syntax-highlighting
```

Homer can add aliases and save them for later use.

```bash
$ homer alias gc 'git commit'
$ gc -m "wow this is cool"
```

It can also delete them.

```bash
$ homer alias --delete gc
```

Homer can copy useful scripts to your `$PATH`.

```bash
$ homer script bin/find-and-replace-in-project
$ find-and-replace-in-project
```

Homer isn't the smartest guy in the world, but he gets the job done.

### Conventions

Homer establishes a number of conventions on your home directory. It
uses the **bin/** directory to store user-made scripts which can be made
available in the path. It creates an **etc/** directory and uses that to
store files such as **etc/plugins** for defining shell plugins and
**etc/aliases** for storing shell aliases you wish to recall later.

## Development

Homer is written entirely in ZSH shell script. It uses [BATS][bats] to
run its tests. All contributions must include tests.

[bats]: https://github.com/sstephenson/bats
