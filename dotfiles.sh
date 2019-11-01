#!/bin/bash

#
# Utility Functionality
#

rm_file() {
    if [ -f $1 ]; then
        echo "Removing $1."
        rm $1
    else
        echo "$1 doesn't exist."
    fi
}

rm_dir() {
    if [ -d $1 ]; then
        echo "Removing $1."
        rmdir $1
    else
        echo "$1 doesn't exist."
    fi
}

mk_dir(){
    if [ ! -d $1 ]; then
        echo "Creating $1..."
        mkdir $1
    else
        echo "$1 already exists."
    fi
}

install_package(){
    # https://stackoverflow.com/questions/1298066/check-if-an-apt-get-package-is-installed-and-then-install-it-if-its-not-on-linu
    PKG_OK=$(dpkg-query -W --showformat='${Status}\n' $1 | grep "install ok installed")
    if [ "" == "$PKG_OK" ]; then
        echo "Installing $1..."
        sudo apt -qq --yes install $1
    else
        echo -e "- \e[1;33m$1\e[0m ✓"
    fi
}

remove_package(){
    # https://stackoverflow.com/questions/1298066/check-if-an-apt-get-package-is-installed-and-then-install-it-if-its-not-on-linu
    PKG_OK=$(dpkg-query -W --showformat='${Status}\n' $1 | grep "install ok installed")
    if [ "" != "$PKG_OK" ]; then
        echo "Uninstalling $1..."
        sudo apt -qq --yes remove $1
    fi
}

git_clone(){
    if [ ! -d $2 ]; then
        echo "Cloning $1 into $2..."
        git clone -q $1 $2
    fi
}

print_section() {
    echo -e "\e[4;1;32m> $1\e[0m"
}

print_subsection() {
    echo -e "\e[4;1;34m$1\e[0m"
}

execute() {   
    $1

    if [ $? -ne 0 ]; then
        echo "Failed to execute command."
        exit
    fi

    echo -e "- \e[1;33m($1)\e[0m ✓"
}

#-------------------------------------------------------------------------------

#
# dotfiles.sh
#

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

#
# VSCode
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

#
# NodeJS
#
if ! command -v nodejs > /dev/null; then
    curl -sL https://deb.nodesource.com/setup_11.x | sudo -E bash -
    install_package nodejs
    echo -e "- \e[1;33mnodejs\e[0m ✓"
fi

if [ ! -d ~/.nvm ] > /dev/null; then
    curl -sL https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh -o install_nvm.sh
    bash install_nvm.sh
    rm install_nvm.sh
    echo -e "- \e[1;33mnvm\e[0m ✓"
fi

#
# PHP
#
install_package php-cli 
install_package php-mbstring 

if ! command -v composer > /dev/null; then
    curl -sS https://getcomposer.org/installer -o composer-setup.php
    php composer-setup.php --install-dir=/usr/local/bin --filename=composer
    echo -e "- \e[1;33mcomposer\e[0m ✓"
fi

if ! command -v phpbrew > /dev/null; then
    curl -L -O https://github.com/phpbrew/phpbrew/raw/master/phpbrew
    chmod +x phpbrew
    sudo mv phpbrew /usr/local/bin/phpbrew
    rm composer-setup.php
    echo -e "- \e[1;33mphpbrew\e[0m ✓"
fi

#
# Python
#
install_package python3 
install_package python-pip 
install_package python3-pip 
install_package tox

if [ ! -d ~/.pyenv ]; then
    curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
    echo -e "- \e[1;33mpyenv\e[0m ✓"
fi

if ! command -v code > /dev/null; then
    curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
    mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
    sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

    curl -L https://vscode-update.azurewebsites.net/latest/linux-deb-x64/stable -o ~/Downloads/code.deb
    sudo dpkg -i ~/Downloads/code.deb
    rm ~/Downloads/code.deb
    echo -e "- \e[1;33mcode\e[0m ✓"
fi

#
# k9s
#

if ! command -v k9s > /dev/null; then
    curl -L https://github.com/derailed/k9s/releases/download/0.7.13/k9s_0.7.13_Linux_x86_64.tar.gz -o ~/Downloads/k9s.tar.gz
    
    cd ~/Downloads
    tar -zxvf ~/Downloads/k9s.tar.gz
    sudo mv ~/Downloads/k9s /usr/local/bin/k9s
    sudo chmod +x /usr/local/bin/k9s

    rm ~/Downloads/k9s.tar.gz
    rm ~/Downloads/LICENSE
    rm ~/Downloads/README.md
    echo -e "- \e[1;33mk9s\e[0m ✓"
fi

#
# kubectl
#

if ! command -v kubectl > /dev/null; then
    sudo apt-get update && sudo apt-get install -y apt-transport-https
    curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
    echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
    sudo apt-get -qq update
    sudo apt-get -qq install -y kubectl
    echo -e "- \e[1;33mkubectl\e[0m ✓"
fi

#
# gvm
#

if ! command -v gvm > /dev/null; then
    bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)
fi

#
# tfenv
#

if ! command -v tfenv > /dev/null; then
    echo "Installing tfenv..."
    git clone https://github.com/tfutils/tfenv.git ~/.tfenv
    echo -e "- \e[1;33mtfenv\e[0m ✓"
fi

install_package neovim

if [ ! -f ~/.local/share/nvim/site/autoload/plug.vim ]; then
    curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    echo -e "- \e[1;33mvim-plug\e[0m ✓"
fi

if ! which docker > /dev/null; then
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"

    install_package docker-ce
    echo -e "- \e[1;33mdocker\e[0m ✓"
fi

if ! which docker-compose > /dev/null; then
    sudo curl -L https://github.com/docker/compose/releases/download/1.24.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    echo -e "- \e[1;33mdocker-compose\e[0m ✓"
fi

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
    install_package typora 
fi

if ! which tlp > /dev/null; then
    add-apt-repository ppa:linrunner/tlp
    install_package tlp 
    install_package tlp-rdw 
fi

if ! which spotify > /dev/null; then
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 931FF8E79F0876134EDDBDCCA87FF9DF48BF1C90
    echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list
    install_package spotify-client  
fi

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

#
# zoom
#

if ! command -v zoom > /dev/null; then
    echo "Installing zoom..."
    wget -O ~/Downloads/zoom.deb https://zoom.us/client/latest/zoom_amd64.deb
    cd ~/Downloads
    sudo dpkg -i zoom.deb
    rm ~/Downloads/zoom.deb
fi

#
# peek
#

if ! command -v peek > /dev/null; then
    echo "Installing peek..."
    sudo add-apt-repository ppa:peek-developers/stable
    sudo apt update
    sudo apt install -y peek
fi

#
# keybase
#
if ! command -v keybase > /dev/null; then
    curl --remote-name https://prerelease.keybase.io/keybase_amd64.deb
    sudo apt install ./keybase_amd64.deb
fi

install_package figlet

print_subsection "User Interface"

install_package gnome-shell-extensions
install_package gnome-tweaks
install_package arc-theme

if [ ! -d ~/.local/share/gnome-shell/extensions/dash-to-dock@micxgx.gmail.com ]; then
    
    echo "Installing Gnome Shell System Monitor..."
    install_package gir1.2-gtop-2.0 
    install_package gir1.2-networkmanager-1.0  
    install_package gir1.2-clutter-1.0

    git clone git://github.com/paradoxxxzero/gnome-shell-system-monitor-applet.git
    cd gnome-shell-system-monitor-applet
    make install
    cd ..
    rm -r gnome-shell-system-monitor-applet
fi

if [ ! -d ~/.local/share/gnome-shell/extensions/system-monitor@paradoxxx.zero.gmail.com ]; then
    echo "Installing Dash to Dock..."

    git clone https://github.com/micheleg/dash-to-dock.git
    cd dash-to-dock
    make
    make install
    cd ..
    rm -r dash-to-dock
fi

if [ ! -d /usr/share/icons/Papirus ]; then
    echo "Installing Papirus Icons..."
    wget -qO- https://raw.githubusercontent.com/PapirusDevelopmentTeam/papirus-icon-theme/master/install.sh | sh
fi 

print_subsection "Remove"

remove_package thunderbird*
remove_package libreoffice*

print_subsection "Cleanup"

execute "sudo apt -qq -y autoremove"

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

print_section "Finished dotfiles.sh..."

figlet "Happy Hacking!"
