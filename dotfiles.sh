#!/bin/bash

#
# Utility Functionality
#

install_package(){
    # https://stackoverflow.com/questions/1298066/check-if-an-apt-get-package-is-installed-and-then-install-it-if-its-not-on-linu
    PKG_OK=$(dpkg-query -W --showformat='${Status}\n' $1 | grep "install ok installed")
    if [ "" == "$PKG_OK" ]; then
        echo "Installing $1..."
        sudo apt -qq --yes install $1
    fi

    echo -e "- \e[1;33m$1\e[0m ✓"
}

remove_package(){
    # https://stackoverflow.com/questions/1298066/check-if-an-apt-get-package-is-installed-and-then-install-it-if-its-not-on-linu
    PKG_OK=$(dpkg-query -W --showformat='${Status}\n' $1 | grep "install ok installed")
    if [ "" != "$PKG_OK" ]; then
        echo "Uninstalling $1..."
        sudo apt -qq --yes remove $1
    fi

    echo -e "- rm \e[1;33m$1\e[0m ✓"
}

print_section() {
    echo -e "\e[4;1;32m> $1\e[0m"
}

print_subsection() {
    echo -e "\e[4;1;34m$1\e[0m"
}

print_execution() {
    echo -e "- \e[1;33m$1\e[0m ✓"
}

execute() {   
    $1

    if [ $? -ne 0 ]; then
        echo "Failed to execute command."
        exit
    fi

    echo -e "- \e[1;33m($1)\e[0m ✓"
}

rm_file() {
    if [ -f $1 ]; then
        execute "rm $1"
    else
        print_execution "rm $1"
    fi
}

rm_dir() {
    if [ -d $1 ]; then
        execute "rmdir $1"
    else
        print_execution "rmdir $1"
    fi
}

mk_dir(){
    if [ ! -d $1 ]; then
        execute "mkdir $1"
    else
        print_execution "mkdir $1"
    fi
}

git_clone(){
    if [ ! -d $2 ]; then
        execute "git clone -q $1 $2"
    else
	print_execution "repo $2"
    fi
}

#-------------------------------------------------------------------------------

#
# dotfiles.sh
#
if [ $EUID != 0 ]; then
    sudo bash -c "echo \"Running script as $USER with root permissions.\""
fi

print_section "Starting dotfiles.sh..."

echo "$(uname -a)"

#
# Symlink with stow.
#
print_section "Generating Symlinks"

execute "stow bash/"
execute "stow config/"
execute "stow git/"
execute "stow ssh/"
execute "stow tmux/"
execute "stow bin/ -t $HOME/.local/bin/"

print_section "Installing Software"

echo "Distribution: $(lsb_release -ds)."

#
# Update
#

print_subsection "Update"

execute "sudo apt -qq update"
execute "sudo apt -qq -y upgrade"

#
# Basics
#

print_subsection "Basics"

install_package make 
install_package build-essential 
install_package curl
install_package apt-transport-https 
install_package ca-certificates 
install_package software-properties-common 
install_package ubuntu-restricted-extras 
install_package git 

#
# Databases
#

print_subsection "Databases"

install_package postgresql-client

#
# Development
#

print_subsection "Development"

if ! command -v nodejs > /dev/null; then
    curl -sL https://deb.nodesource.com/setup_11.x | sudo -E bash -
fi

if ! command -v kubectl > /dev/null; then
    sudo apt-get update && sudo apt-get install -y apt-transport-https
    curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
    echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
    sudo apt-get -qq update
fi

if ! which docker > /dev/null; then
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
fi

install_package nodejs
install_package php-cli 
install_package php-mbstring 
install_package python3 
install_package python-pip 
install_package python3-pip 
install_package tox
install_package kubectl
install_package neovim
install_package docker-ce

# nvm

if [ ! -d ~/.nvm ] > /dev/null; then
    curl -sL https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh -o install_nvm.sh
    bash install_nvm.sh
    rm install_nvm.sh
fi

print_execution "nvm"

# composer

if ! command -v composer > /dev/null; then
    curl -sS https://getcomposer.org/installer -o composer-setup.php
    php composer-setup.php --install-dir=/usr/local/bin --filename=composer
fi

print_execution "composer"

# phpbrew 

if ! command -v phpbrew > /dev/null; then
    curl -L -O https://github.com/phpbrew/phpbrew/raw/master/phpbrew
    chmod +x phpbrew
    sudo mv phpbrew /usr/local/bin/phpbrew
    rm composer-setup.php
fi

print_execution "phpbrew"

# pyenv

if [ ! -d ~/.pyenv ]; then
    curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
fi

print_execution "pyenv"

# code

if ! command -v code > /dev/null; then
    curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
    mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
    sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

    curl -L https://vscode-update.azurewebsites.net/latest/linux-deb-x64/stable -o ~/Downloads/code.deb
    sudo dpkg -i ~/Downloads/code.deb
    rm ~/Downloads/code.deb
fi

print_execution "code"

# k9s

if ! command -v k9s > /dev/null; then
    curl -L https://github.com/derailed/k9s/releases/download/0.7.13/k9s_0.7.13_Linux_x86_64.tar.gz -o ~/Downloads/k9s.tar.gz
    
    cd ~/Downloads
    tar -zxvf ~/Downloads/k9s.tar.gz
    sudo mv ~/Downloads/k9s /usr/local/bin/k9s
    sudo chmod +x /usr/local/bin/k9s

    rm ~/Downloads/k9s.tar.gz
    rm ~/Downloads/LICENSE
    rm ~/Downloads/README.md
fi

print_execution "k9s"

# gvm

if ! command -v gvm > /dev/null; then
    bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)
fi

print_execution "gvm"

# tfenv

if ! command -v tfenv > /dev/null; then
    git clone https://github.com/tfutils/tfenv.git ~/.tfenv
fi

print_execution "tfenv"

# vim-plug

if [ ! -f ~/.local/share/nvim/site/autoload/plug.vim ]; then
    curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

print_execution "vim-plug"

# docker-compose

if ! which docker-compose > /dev/null; then
    sudo curl -L https://github.com/docker/compose/releases/download/1.24.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
fi

print_execution "docker-compose"

print_subsection "Libraries"

install_package libssl-dev 
install_package zlib1g-dev 
install_package libbz2-dev 
install_package libreadline-dev 
install_package libsqlite3-dev 
install_package libncurses5-dev 
install_package libncursesw5-dev 
install_package libffi-dev 
install_package liblzma-dev

print_subsection "Miscellaneous"

if ! which typora > /dev/null; then
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys BA300B7755AFCFAE
    add-apt-repository 'deb https://typora.io/linux ./'
fi

if ! which tlp > /dev/null; then
    add-apt-repository ppa:linrunner/tlp
fi

if ! which spotify > /dev/null; then
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 931FF8E79F0876134EDDBDCCA87FF9DF48BF1C90
    echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list
fi

if ! command -v peek > /dev/null; then
    sudo add-apt-repository ppa:peek-developers/stable
    sudo apt update
fi

install_package tlp-rdw 
install_package tlp 
install_package spotify-client  
install_package typora 
install_package wget 
install_package llvm  
install_package xz-utils 
install_package jq 
install_package httpie  
install_package tmux 
install_package unzip 
install_package vim 
install_package texlive-full 
install_package openconnect 
install_package subversion 
install_package xclip 
install_package pandoc 
install_package powertop 
install_package htop
install_package peek
install_package figlet

# zoom

if ! command -v zoom > /dev/null; then
    wget -O ~/Downloads/zoom.deb https://zoom.us/client/latest/zoom_amd64.deb
    cd ~/Downloads
    sudo dpkg -i zoom.deb
    rm ~/Downloads/zoom.deb
fi

print_execution "zoom"

# keybase

if ! command -v keybase > /dev/null; then
    curl --remote-name https://prerelease.keybase.io/keybase_amd64.deb
    sudo apt install ./keybase_amd64.deb
    rm ./keybase_amd64.deb
fi

print_execution "keybase"

print_subsection "User Interface"

install_package gnome-shell-extensions
install_package gnome-tweaks
install_package arc-theme

# gnome-shell-system-monitor-applet

if [ ! -d ~/.local/share/gnome-shell/extensions/system-monitor@paradoxxx.zero.gmail.com ]; then
    install_package gir1.2-gtop-2.0 
    install_package gir1.2-networkmanager-1.0  
    install_package gir1.2-clutter-1.0

    git clone git://github.com/paradoxxxzero/gnome-shell-system-monitor-applet.git
    cd gnome-shell-system-monitor-applet
    make install
    cd ..
    rm -r gnome-shell-system-monitor-applet
fi

print_execution "gnome-shell-system-monitor-applet"

# dash-to-dock

if [ ! -d ~/.local/share/gnome-shell/extensions/dash-to-dock@micxgx.gmail.com ]; then
    git clone https://github.com/micheleg/dash-to-dock.git
    cd dash-to-dock
    make
    make install
    cd ..
    rm -r dash-to-dock
fi

print_execution "dash-to-dock"

# papirus-icon-theme

if [ ! -d /usr/share/icons/Papirus ]; then
    wget -qO- https://raw.githubusercontent.com/PapirusDevelopmentTeam/papirus-icon-theme/master/install.sh | sh
fi

print_execution "papirus-icon-theme"

print_subsection "Remove"

remove_package thunderbird*
remove_package libreoffice*

print_subsection "Cleanup"

execute "sudo apt -qq -y autoremove"

#
#VSCode Extensions
#
print_section "VSCode Extensions"

uninstall=$(diff -u <(code --list-extensions) <(cat vscode/extensions))
install=$(diff -u <(code --list-extensions) <(cat vscode/extensions))

echo "U: $(echo "$uninstall" | grep -E "^\-[^-]" | wc -l). I: $(echo "$uninstall" | grep -E "^\+[^+]" | wc -l)."

echo "$uninstall" | grep -E "^\-[^-]" | sed -e "s/-//" | while read -r line; do
    execute "code --uninstall-extension $line"
    ((counter++))
done

echo "$install" | grep -E "^\+[^+]" | sed -e "s/+//" | while read -r line; do
    execute "code --install-extension $line"
    ((counter++))
done

#
# Desktop
# 

print_section "Customizing Desktop"

rm_file ~/examples.desktop

rm_dir ~/Documents/ 
rm_dir ~/Music/ 
rm_dir ~/Pictures/ 
rm_dir ~/Public/ 
rm_dir ~/Templates/ 
rm_dir ~/Videos/

mk_dir ~/Dev/

#
# Repos
#

print_section "Clone Repos"

http https://api.github.com/users/caramelomartins/repos | jq .[].ssh_url | while read -r line; do
    name=$(echo $line | sed -e 's/"git@github.com:caramelomartins\///' | sed -e 's/.git"//')

    if [ "$name" != "dotfiles" ]; then
	git_clone $line "$HOME/Dev/$name"
    fi
done

print_section "Customize Workflow"

execute "sudo update-alternatives --set editor /usr/bin/nvim"

print_section "Finished dotfiles.sh..."

figlet "Happy Hacking!"
