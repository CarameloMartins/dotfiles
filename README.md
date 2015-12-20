# dotfiles

This repo is a collection of my dotfiles and some custom scripts along with setup configurations
and bootstrap scripts.

## Concept

## Installation
As of this moment, no automatic installation of files exists.

### Remove

## Structure
- `atom` - Custom Atom configurations and packages' settings.
- `bin` - Personal `bin` folder that will be installed into `$HOME`.
  - `exip.sh` - Gets device's external IP.
  - `update.sh` - Updates/upgrades system with `apt-get`.
- `git` - Global `git` configurations.
  - `gitconfig` - Global `git` configurations.
  - `gitignore` - Global `gitignore` file.
- `scripts` - Custom scripts for dotfiles management.
  - `bootstrap.sh` - Bootsraps system for dotfiles installation.
  - `install.sh` - Installs dotfiles.
  - `remove-sh` - Removes dotfiles.
- `terminal` - Terminal custom settings.
  - `bash_aliases` - Holds `bash` aliases.
  - `bash_exports` - Holds `bash` exports.
  - `bash_functions` - Holds `bash` functions.
  - `bash_paths` - Holds `bash` path configurations.
  - `bash_profile` - Holds main `bash` configs and sources other files.
  - `bash_prompt` - Holds prompt configurations.
  - `bashrc` - `bash` loading file.

## License
[MIT](LICENSE.md)
