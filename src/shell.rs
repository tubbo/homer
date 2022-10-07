use std::process::Command;

/// Run a command on the shell.
pub fn run(command: &str, arg: &str) {
    Command::new(command).arg(arg);
}
