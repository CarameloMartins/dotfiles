# dotfiles

This repo is a collection of my dotfiles and some custom scripts along with setup
configurations and bootstrap scripts.

## Requirements

- stow
- git
- curl
- brew (on MacOS)

## Instructions

- Run `dotfiles.sh`.
- `git` - This will set global `.gitconfig` and `.gitignore` files. For privacy, email and user should be set in another file (`~/.gitconfig.id)` and will be included in the configuration.
- Update VS Code extensions: `code --list-extensions > vscode/extensions`.

## Usage
```hugo.martins at LIS-MBP16-0012 in ~/.dotfiles
$ dotfiles --help
caramelomartins' dotfiles for MacOS and Linux

Usage: ./dotfiles.sh [options] [commands]

commands:
  update            update git repository of dotfiles
  edit              edit dotfiles.sh
  status            show current status of git repository
  install           install software and update necessary installation files
  issue             open an issue in dotfiles Github repository

options:
    -h, --help        show help
    -a, --all         do everything dotfiles.sh can do
    -c, --cleanup     cleanup with package manager
    -i, --install     install software
    -r, --repos       clone all of caramelomartins' publics repo
    -s, --symlink     symlink files to /Users/hugo.martins
    -u, --update      update installed software
    -w, --workflow    configure UI and workflow stuff

notes:
    - repos are only cloned if called explicitly.
    - options are only relevant when you run the script without a command.
```
**Available Commands:**

- `dotfiles status`: displays `git status` on the dotfiles repository.
- `dotfiles edit`: opens vim with `dotfiles.sh` for editing.
- `dotfiles update`: executes `git pull` on the repository to update it.
- `dotfiles install`: execute `install` function and add information to installation scripts.
- `dotfiles issue`: execute `hub issue create` inside the dotfiles repository to create an instant issue in Github.

## Resources

[dotfiles.github.com](http://dotfiles.github.com) and all the contributors referenced
in that page along with all dotfiles repos in [github.com](http://github.com) were my
main sources of inspiration and reference.

Along with stolen scripts from
[stackoverflow.com](http://stackoverflow.com) whenever necessary that are mentioned inside the scripts.

## License

[MIT](LICENSE.md)
