#!/usr/bin/env bash

# common.sh
# 
# Install software that has a common installation process in both Linux and MacOs.

install awscli
install curl
install cloc
install figlet
install htop
install httpie  
install jq 
install make
install neovim
install pandoc 
install tmux 
install tox
install unzip
install wget
install lynx
install bash-completion

install bin phpbrew https://github.com/phpbrew/phpbrew/raw/master/phpbrew

install bash dir nvm ~/.nvm https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh
install bash dir pyenv ~/.pyenv https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer
install bash cmd gvm https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer

install clone tpm https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# composer

if ! command -v composer > /dev/null; then
    curl -sS https://getcomposer.org/installer -o composer-setup.php
    sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer
    rm composer-setup.php
fi

print_execution "composer"

# vim-plug

if [ ! -f ~/.local/share/nvim/site/autoload/plug.vim ]; then
    curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

print_execution "vim-plug"
