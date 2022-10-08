use std::process::Command;
use std::path::{Path};

/// Run a command on the shell.
pub fn run(command: &str, arg: &str) {
    Command::new(command).arg(arg);
}

/// Run a shellscript with ZSH
pub fn script(file: &str) {
    let path = Path::new(file);
        
    if path.exists() {
        run("zsh", file);
    }
}