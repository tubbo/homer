use git2::{Repository,RepositoryInitOptions,Tree,Oid,Index};
use std::fs::{write,rename,remove_dir_all};
use std::path::{Path, PathBuf};
use home::home_dir;

// Find the user's home directory.
fn find_home_dir() -> PathBuf {
    match home_dir() {
        Some(path) => path,
        None => panic!("Home directory cannot be found.")
    }
}

// Write a given path to the index and output the tree ID
fn stage(mut index: Index, path: &Path) -> Oid {
    match index.add_path(path) {
        Ok(_) => {},
        Err(e) => panic!("Couldn't add path to index: {}", e)
    };
    match index.write() {
        Ok(_) => {},
        Err(e) => panic!("Couldn't write to index: {}", e),
    };
    
    match index.write_tree() {
        Ok(id) => id,
        Err(e) => panic!("Writing tree failed: {}", e),
    }    
}

// Add a file to the repository and return the new Tree
fn add<'r>(repo: &'r Repository, file: PathBuf) -> Tree<'r> {
    let path = file.as_path();
    let index = match repo.index() {
        Ok(i) => i,
        Err(e) => panic!("Couldn't open index: {}", e)
    };
    let id = stage(index, &path);
    
    match repo.find_tree(id) {
        Ok(tree) => tree,
        Err(e) => panic!("Couldn't find tree: {}", e)
    }
}

/// Initialize a new Git repository for the home directory.
pub fn init() {
    let mut opts = RepositoryInitOptions::new();
    let mut ignore = find_home_dir();
    let home = find_home_dir();
    
    ignore.push(".gitignore");
    opts.mkdir(false);
    opts.mkpath(false);
    opts.no_reinit(false);
    
    let msg = "initial commit";
    let repo = match Repository::init_opts(home, &opts) {
        Ok(repo) => repo,
        Err(e) => panic!("Failed to initialize Homer repository: {}", e),
    };  
    let author = match repo.signature() {
        Ok(author) => author,
        Err(e) => panic!("Failed to find Git author: {}", e)
    };
    let tree = match write(ignore.as_path(), b"/*") {
        Ok(_) => add(&repo, ignore),
        Err(e) => panic!("Error writing file: {}", e),
    };

    match repo.commit(None, &author, &author, msg, &tree, &[]) {
        Ok(commit) => commit,
        Err(e) => panic!("Couldn't write initial commit: {}", e),
    };
}

/// Clone an existing Git repository into the home directory.
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
