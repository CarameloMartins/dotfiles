. ./utils.sh

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

if command -v zoom > /dev/null; then
    echo "Installing zoom..."
    wget -O ~/Downloads/zoom.deb https://zoom.us/client/latest/zoom_amd64.deb
    cd ~/Downloads
    dpkg -i zoom.deb
    rm ~/Downloads/zoom.deb
fi

#
# peek
#

if command -v peek > /dev/null; then
    echo "Installing peek..."
    add-apt-repository ppa:peek-developers/stable
    sudo apt update
    sudo apt install -y peek
fi

#
# keybase
#
if command -v keybase > /dev/null; then
    curl --remote-name https://prerelease.keybase.io/keybase_amd64.deb
    sudo apt install ./keybase_amd64.deb
fi