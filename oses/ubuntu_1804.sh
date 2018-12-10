# Home Directories
rm examples.desktop
rmdir Documents/ Music/ Pictures/ Public/ Templates/ Videos/
mkdir Projects/

# Update and Upgrade
apt update && sudo apt upgrade

# Remove Software
apt remove thunderbird* libreoffice*

# Keys
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 931FF8E79F0876134EDDBDCCA87FF9DF48BF1C90
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
curl -sL https://deb.nodesource.com/setup_8.x -o nodesource_setup.sh
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys BA300B7755AFCFAE

# Sources
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sudo add-apt-repository 'deb https://typora.io/linux ./'

apt update

# Software
apt install ubuntu-restricted-extras git tmux apt-transport-https ca-certificates curl software-properties-common spotify-client  unzip vim texlive-full typora openconnect subversion xclip pandoc

# Development Tools
apt install make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev jq httpie

# Python
apt install python3 python-pip python3-pip tox
curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash

# Node
bash nodesource_setup.sh
apt install nodejs
rm nodesource_setup.sh

curl -sL https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh -o install_nvm.sh
bash install_nvm.sh
rm install_nvm.sh

# PHP
apt install php-cli php-mbstring 
curl -sS https://getcomposer.org/installer -o composer-setup.php
php composer-setup.php --install-dir=/usr/local/bin --filename=composer
curl -L -O https://github.com/phpbrew/phpbrew/raw/master/phpbrew
chmod +x phpbrew
mv phpbrew /usr/local/bin/phpbrew
rm composer-setup.php

# Go
git clone https://github.com/syndbg/goenv.git ~/.goenv
echo 'export GOENV_ROOT="$HOME/.goenv"' >> ~/.bashrc
echo 'export PATH="$GOENV_ROOT/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(goenv init -)"' >> ~/.bashrc

go get github.com/gopasspw/gopass

# Databases
apt install postgresql-client

# Development
apt install docker-ce

# Appearance
apt install adwaita-icon-theme-full gnome-shell-extensions gnome-tweaks gir1.2-gtop-2.0 gir1.2-networkmanager-1.0  gir1.2-clutter-1.0

git clone git://github.com/paradoxxxzero/gnome-shell-system-monitor-applet.git
cd gnome-shell-system-monitor-applet
make install
cd ..
rm -r gnome-shell-system-monitor-applet


# Docker Compose
sudo curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# VSCode
curl -L https://vscode-update.azurewebsites.net/latest/linux-deb-x64/stable -o ~/Downloads/code.deb
dpkg -i ~/Downloads/code.deb
rm ~/Downloads/code.deb
