# dotfiles

This repo is a collection of my dotfiles and some custom scripts along with setup
configurations and bootstrap scripts.

**Status:**  
[![Build Status](https://travis-ci.org/caramelomartins/dotfiles.svg?branch=master)](https://travis-ci.org/caramelomartins/dotfiles)

_Disclaimer: I can't guarantee any of the scripts won't mess anything up. This repository is an ongoing experience for me._

## Concepts
When dealing with my configurations there are some goals I always try to keep
in mind:
- Automation - Automation is cool and I like to do the same thing twice as much
as anyone.
- Simplicity - I don't enjoy overly complicated setups that are so hard to understand
they start to become useless.
- Portability - I try to make my scripts as generic as I'm able to, to be able to
use them in all my devices.

Most, if not all of, my scripts in this repo are written in Bash which means they
are easily portable to other UNIX systems.

## Installation

For first install, navigate to the folder where you want `dotfiles` repository to be
stored and then:

```
wget https://raw.githubusercontent.com/caramelomartins/dotfiles/master/scripts/bootstrap.sh
sh bootstrap.sh
```

For futher installs:
- Navigate to the repository's folder.
- Grant access to `script/install.sh` with:

```
chmod +x ./scripts/install.sh
```

- Run:

```
./scripts/install.sh
```

### Remove

- Navigate to the repository's folder.
- Grant access to `script/remove.sh` with:

```
chmod +x ./scripts/remove.sh
```

- Run:

```
./scripts/remove.sh
```

## Structure
The dotfiles behave in a sort of modular way. Each component has installation and removal scripts and the main `install.sh` and `remove.sh` that are located in the `script` folder will call all of them, respectively.  

There are some files that are copied into '~' and there are some files that are symlinked into '~'. Along with these files, some files like `gitconfig` are used in specific ways due to security or privacy concerns.

Below is the folder structure and a short summary:

- `atom` - Custom Atom configurations and packages' settings.
- `bin` - Personal `bin` folder that will be installed into `$HOME`.
  - `exip.sh` - Gets device's external IP.
  - `update.sh` - Updates/upgrades system.
- `git` - Global `git` configurations.
  - `gitconfig` - Global `git` configurations.
  - `gitignore` - Global `gitignore` file.
- `scripts` - Custom scripts for dotfiles management.
  - `bootstrap.sh` - Bootstraps system for dotfiles installation.
- `terminal` - Terminal custom settings.
  - `bash_aliases` - Aliases that will be sourced to bash.
  - `bash_logout` - Default Ubuntu logout shell script.
  - `bash_profile` - Holds main `bash` configs and sources other files.
  - `bash_prompt` - Holds prompt configurations.
  - `bashrc` - `bash` loading file.

## Resources
[dotfiles.github.com](http://dotfiles.github.com) and all the contributors referenced
in that page along with all dotfiles repos in [github.com](http://github.com) were my
main sources of inspiration and reference.  

Along with stolen scripts from
[stackoverflow.com](http://stackoverflow.com) whenever necessary that are mentioned inside the scripts.

## License
[MIT](LICENSE.md)
