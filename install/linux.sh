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
install postgresql-client
install powertop
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

install clone kube-ps1 https://github.com/jonmosco/kube-ps1.git "$HOME/.kube-ps1"
