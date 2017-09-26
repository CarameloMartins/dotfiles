#!/usr/bin/env bash
#
# Install dotfiles, configurations and packages in a machine.

##
# This function is used to be able to tell where a script file is and enter its
# directory
#
# Source:
#   http://stackoverflow.com/questions/59895/can-a-bash-script-tell-what-directory-its-stored-in
##
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$DIR" || exit

DOTFILES=${DIR%/*}

###############################################################################
# Update and Upgrade
###############################################################################
sudo apt-get update && sudo apt-get upgrade -y

###############################################################################
# Install utilities.
###############################################################################
sudo apt-get install -y $(cat install/apt/utilities)

###############################################################################
# Sources need for installations.
###############################################################################

# Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# Visual Studio Code
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

# Spotify
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886 0DF731E45CE24F27EEEB1450EFDC8610341D9410
echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list

# Nextcloud
sudo add-apt-repository ppa:nextcloud-devs/client

# Weather Indicator
sudo add-apt-repository ppa:kasra-mp/ubuntu-indicator-weather

# Typora
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys BA300B7755AFCFAE
sudo add-apt-repository 'deb http://typora.io linux/'

# Zotero
sudo apt-add-repository ppa:smathot/cogscinl 

# Ubuntu Tweak
wget -q -O - http://archive.getdeb.net/getdeb-archive.key | sudo apt-key add -
sudo sh -c 'echo "deb http://archive.getdeb.net/ubuntu xenial-getdeb apps" >> /etc/apt/sources.list.d/getdeb.list'

# Flatabulous
sudo add-apt-repository ppa:noobslab/themes
sudo add-apt-repository ppa:noobslab/icons

###############################################################################
# Refresh database.
###############################################################################
sudo apt-get update

###############################################################################
# Install remaining APT packages.
###############################################################################
sudo apt-get install -y $(cat install/apt/databases)
sudo apt-get install -y $(cat install/apt/dev)
sudo apt-get install -y $(cat install/apt/media)
sudo apt-get install -y $(cat install/apt/security)

###############################################################################
# Purge needless packages.
###############################################################################
sudo apt-get purge -y $(cat install/apt/purge)

###############################################################################
# Clean up.
###############################################################################
sudo apt-get autoremove && sudo apt-get clean 

###############################################################################
# Google Chrome
###############################################################################

###############################################################################
# Postman
###############################################################################
wget https://dl.pstmn.io/download/latest/linux64 -O postman.tar.gz
sudo tar -xzf postman.tar.gz -C /opt
rm postman.tar.gz
sudo ln -s /opt/Postman/Postman /usr/bin/postman

###############################################################################
# soapUI
###############################################################################

###############################################################################
# PHPBrew
###############################################################################
curl -L -O https://github.com/phpbrew/phpbrew/raw/master/phpbrew
chmod +x phpbrew
sudo mv phpbrew /usr/local/bin/phpbrew

###############################################################################
# WPS office
###############################################################################

###############################################################################
# Dropbox
###############################################################################

###############################################################################
# Composer
###############################################################################
sudo curl -s https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer

###############################################################################
# Install composer packages.
###############################################################################
composer global require $(cat install/composer)

###############################################################################
# VirtualBox
###############################################################################
wget http://download.virtualbox.org/virtualbox/5.1.28/virtualbox-5.1_5.1.28-117968~Ubuntu~xenial_i386.deb -O virtualbox.deb
sudo dpkg -i virtualbox.deb
rm virtualbox.deb
sudo apt-get install -f

# Sign Module
#
# Source:
#   https://askubuntu.com/questions/760671/could-not-load-vboxdrv-after-upgrade-to-ubuntu-16-04-and-i-want-to-keep-secur
openssl req -new -x509 -newkey rsa:2048 -keyout MOK.priv -outform DER -out MOK.der -nodes -days 36500 -subj "/CN=Hugo Martins/"
sudo /usr/src/linux-headers-$(uname -r)/scripts/sign-file sha256 ./MOK.priv ./MOK.der $(modinfo -n vboxdrv)
sudo mokutil --import MOK.der
rm MOK.*

###############################################################################
# Clean Home Folder
###############################################################################
rm -rf ~/Documents
rm -rf ~/Public
rm -rf ~/Templates
rm -rf ~/Videos
rm -rf ~/Music
rm -rf ~/Pictures
rm ~/examples.desktop