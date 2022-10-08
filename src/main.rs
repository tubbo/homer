mod cli;
mod git;
mod zsh;

fn main() {    
    let cli = cli::parse();

    match &cli.command {
        cli::Commands::Init {} => {
            git::init();
            println!("Initialized new Homer repository.");
        },
        cli::Commands::Bootstrap { url } => {
            git::clone(&url);
            zsh::script("~/bin/bootstrap.zsh");
            println!("Bootstrapped existing Homer repository.");
        },
    };   
}
