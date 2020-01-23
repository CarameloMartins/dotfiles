#!/usr/bin/env bash

# linux.sh
#
# Install software that is only installed in Linux-based machines.

install apt-transport-https 
install build-essential 
install ca-certificates 
install docker-ce
install kubectl
install libbz2-dev 
install libffi-dev 
install liblzma-dev
install libncurses5-dev 
install libncursesw5-dev 
install libreadline-dev 
install libsqlite3-dev 
install libssl-dev 
install llvm  
install nodejs
install peek
install php-cli 
install php-mbstring 
install postgresql-client
install powertop 
install python-pip 
install python3 
install python3-pip 
install software-properties-common 
install spotify-client  
install texlive-full 
install tlp 
install tlp-rdw 
install typora 
install ubuntu-restricted-extras
install wget 
install xclip 
install xz-utils 
install zlib1g-dev
install procps

install gnome-shell-extensions
install gnome-tweaks
install arc-theme

install gir1.2-gtop-2.0 
install gir1.2-nm-1.0  
install gir1.2-clutter-1.0

install deb hugo https://github.com/gohugoio/hugo/releases/download/v0.60.0/hugo_0.60.0_Linux-64bit.deb
install deb code https://vscode-update.azurewebsites.net/latest/linux-deb-x64/stable
install deb zoom https://zoom.us/client/latest/zoom_amd64.deb
install deb keybase https://prerelease.keybase.io/keybase_amd64.deb
install deb gopass https://github.com/gopasspw/gopass/releases/download/v1.8.6/gopass-1.8.6-linux-amd64.deb

install bin docker-compose "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" 

install bin minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 

install clone tfenv https://github.com/tfutils/tfenv.git ~/.tfenv
install clone asdf https://github.com/asdf-vm/asdf.git ~/.asdf

install tar k9s https://github.com/derailed/k9s/releases/download/0.7.13/k9s_0.7.13_Linux_x86_64.tar.gz 

install zip op "https://cache.agilebits.com/dist/1P/op/pkg/v0.8.0/op_linux_amd64_v0.8.0.zip"

install tar hub https://github.com/github/hub/releases/download/v2.13.0/hub-linux-amd64-2.13.0.tgz  hub-linux-amd64-2.13.0/bin/

install bash dir papirus-icon-theme /usr/share/icons/Papirus https://raw.githubusercontent.com/PapirusDevelopmentTeam/papirus-icon-theme/master/install.sh

# awscli

if ! command -v aws > /dev/null; then
    curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "$HOME/Downloads/awscli-bundle.zip"
    unzip "$HOME/Downloads/awscli-bundle.zip" -d "$HOME/Downloads"
    sudo "$HOME/Downloads/awscli-bundle/install" -i /usr/local/aws -b /usr/local/bin/aws
    sudo rm -r "$HOME/Downloads/awscli-bundle.zip" "$HOME/Downloads/awscli-bundle"
    echo -e "- \033[01;33maws\033[00m ✓"
fi

# pre-commit

if ! command -v pre-commit > /dev/null; then
    curl https://pre-commit.com/install-local.py | python -
fi

# gnome-shell-system-monitor-applet

if [ ! -d ~/.local/share/gnome-shell/extensions/system-monitor@paradoxxx.zero.gmail.com ]; then
    git clone git://github.com/paradoxxxzero/gnome-shell-system-monitor-applet.git
    cd gnome-shell-system-monitor-applet || exit
    make install
    cd .. || exit
    sudo rm -r gnome-shell-system-monitor-applet
fi

print_execution "gnome-shell-system-monitor-applet"

# dash-to-dock

if [ ! -d ~/.local/share/gnome-shell/extensions/dash-to-dock@micxgx.gmail.com ]; then
    curl https://extensions.gnome.org/review/download/12397.shell-extension.zip -LO
    unzip 12397.shell-extension.zip -d ~/.local/share/gnome-shell/extensions/dash-to-dock@micxgx.gmail.com/
    rm 12397.shell-extension.zip
fi

print_execution "dash-to-dock"

install clone kube-ps1 https://github.com/jonmosco/kube-ps1.git "$HOME/.kube-ps1"
