mod cli;
mod git;
mod shell;
use cli::{Commands,parse_arguments};
use git::{init,clone};
use shell::run;

fn main() {    
    let cli = parse_arguments();

    match &cli.command {
        Commands::Init {} => {
            init();
            println!("Initialized new Homer repository.");
        },
        Commands::Bootstrap { url } => {
            clone(url);
            run("zsh", "~/bin/bootstrap.zsh");
            println!("Bootstrapped existing Homer repository.");
        },
    };   
}
