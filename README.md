# dotfiles

This repo is a collection of my dotfiles and some custom scripts along with setup
configurations and bootstrap scripts.

## Instructions

- `stow` each of the directories, except `oses`, and it will and `stow` will do its magic.
- `git` - This will set global `.gitconfig` and `.gitignore` files. For privacy, email and user should be set at the system or local level, with `--system` or `--local` flags.
- Install extensions with `cat vscode/extensions | xargs -L1 code --install-extensions`.
- UI:
    - Arc Dark Theme
    - Papirus Icon Theme
    - Dash to Dock
    - Shell:
      - Theme: Custom Solarized with White Text
- Run `os/setup.sh`.


## Resources

[dotfiles.github.com](http://dotfiles.github.com) and all the contributors referenced
in that page along with all dotfiles repos in [github.com](http://github.com) were my
main sources of inspiration and reference.

Along with stolen scripts from
[stackoverflow.com](http://stackoverflow.com) whenever necessary that are mentioned inside the scripts.

## License

[MIT](LICENSE.md)
