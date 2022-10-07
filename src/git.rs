use git2::{Repository,RepositoryInitOptions};
use std::fs::{write,rename,remove_dir_all,create_dir_all};
use std::path::{Path, PathBuf};
use home::home_dir;

fn find_home_dir() -> PathBuf {
    match home_dir() {
        Some(path) => path,
        None => panic!("Home directory cannot be found.")
    }
}

pub fn init() {
    let mut opts = RepositoryInitOptions::new();
    let home = find_home_dir();
    
    opts.mkdir(false);
    opts.mkpath(false);
    opts.no_reinit(false);
    opts.external_template(true);
    opts.template_path(Path::new("/tmp/homer-repo"));
    
    match create_dir_all("/tmp/homer-repo") {
        Ok(r) => r,
        Err(e) => panic!("Couldn't write Homer templates dir: {}", e)
    }
    match write("/tmp/homer-repo/.gitignore", b"!/*") {
        Ok(r) => r,
        Err(e) => panic!("Couldn't write .gitignore template: {}", e)
    }
    
    let msg = "initial commit";
    let repo = match Repository::init_opts(home, &opts) {
        Ok(repo) => repo,
        Err(e) => panic!("Failed to initialize Homer repository: {}", e),
    };  
    let author = match repo.signature() {
        Ok(author) => author,
        Err(e) => panic!("Failed to find Git author: {}", e)
    };
    let tree = match &repo.head() {
        Ok(reference) => {
            match reference.peel_to_tree() {
                Ok(tree) => tree,
                Err(e) => panic!("Failed to find current tree: {}", e)
            }
        },
        Err(e) => panic!("Failed to find current head: {}", e)
    };

    match repo.commit(None, &author, &author, msg, &tree, &[]) {
        Ok(commit) => commit,
        Err(e) => panic!("Couldn't write initial commit: {}", e),
    };
    match remove_dir_all("/tmp/homer-repo") {
        Ok(r) => r,
        Err(e) => panic!("Cleanup of template dir failed: {}", e),
    }
}

pub fn clone(url: &String) {
    let location = url.as_str();
    let mut tmp = PathBuf::new();
    let mut home = find_home_dir();
    let mut cloned = tmp.clone();    

    tmp.push("/tmp/homer");
    match remove_dir_all(tmp.as_path()) {
        Ok(r) => r,
        Err(e) => println!("Warning: {}", e)
    };
    match Repository::clone(location, tmp.as_path()) {
        Ok(repo) => repo,
        Err(e) => panic!("Failed to clone Homer repository: {}", e),
    };
    
    home.push(".git");
    cloned.push(".git");
    
    match rename(cloned.as_path(), home.as_path()) {
        Ok(r) => r,
        Err(e) => panic!("Couldn't rename to ~/.git: {}", e),
    }
}
