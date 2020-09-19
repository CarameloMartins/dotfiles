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
install bash-completion
install zsh

install bash dir pyenv ~/.pyenv https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer
install bash cmd gvm https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer

install clone tpm https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
install clone ohmyzsh https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh

# vim-plug

if [ ! -f ~/.local/share/nvim/site/autoload/plug.vim ]; then
    curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

print_execution "vim-plug"

if [ ! -d "$(pyenv root)/plugins/pyenv-virtualenv" ]; then
    git clone https://github.com/pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv
fi

print_execution "pyenv-virtualenv"
