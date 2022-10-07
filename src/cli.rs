use clap::{Parser, Subcommand};

#[derive(Parser)]
#[command(about = "The home directory repository manager", long_about = "The home directory repository manager\n\nHomer is a tool for your shell that allows for fully checking in your home directory as a Git repository. Similar to GNU Stow, this helps track changes of your configuration as well as keep a backup in case one of your machines fail.\n\nHomer is designed for people who spend most of their time in the shell, and use tooling that doesn't always conform to the XDG config standard.\n\nMore info: https://tubbo.github.io/homer")]
#[command(version = "1.0", long_version = "1.0.0", propagate_version = true)]
pub struct Cli {
    #[command(subcommand)]
    pub command: Commands
}

#[derive(Subcommand)]
pub enum Commands {   
    /// Initialize a new Git repository in the home directory without disturbing
    /// the existing files. Adds a ~/.gitignore file and generates an initial
    /// commit which will only allow new files to be added by running `git add -f`
    /// or the convenience command `homer add [FILE]`.
    Init {},
    
    /// Clone an existing Git repository into the home directory. If the file
    /// exists, this command also runs a `bootstrap.zsh` script in your home
    /// directory repo that can be used to install software, configure the
    /// machine, or perform any number of other setup tasks for the new
    /// workstation.
    Bootstrap {
        url: String,
    }
}

// Parse the command-line arguments and return a `Cli` instance containing
// its results.
pub fn parse_arguments() -> Cli {
    return Cli::parse();
}