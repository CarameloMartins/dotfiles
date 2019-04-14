. ./utils.sh

#
# NodeJS
#
if ! command -v nodejs > /dev/null; then
    echo "Installing nodejs..."
    curl -sL https://deb.nodesource.com/setup_11.x | sudo -E bash -
    install_package nodejs
fi

if [ ! -d ~/.nvm ] > /dev/null; then
    echo "Installing nvm..."
    curl -sL https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh -o install_nvm.sh
    bash install_nvm.sh
    rm install_nvm.sh
fi

#
# PHP
#
install_package php-cli 
install_package php-mbstring 

if ! command -v composer > /dev/null; then
    echo "Installing composer..."
    curl -sS https://getcomposer.org/installer -o composer-setup.php
    php composer-setup.php --install-dir=/usr/local/bin --filename=composer
fi

if ! command -v phpbrew > /dev/null; then
    echo "Installing phpbrew..."
    curl -L -O https://github.com/phpbrew/phpbrew/raw/master/phpbrew
    chmod +x phpbrew
    mv phpbrew /usr/local/bin/phpbrew
    rm composer-setup.php
fi

#
# Python
#
install_package python3 
install_package python-pip 
install_package python3-pip 
install_package tox

if [ ! -d ~/.pyenv ]; then
    echo "Installing pyenv..."
    curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
fi

if ! command -v code > /dev/null; then
    echo "Installing VSCode..."
    curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
    mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
    sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

    curl -L https://vscode-update.azurewebsites.net/latest/linux-deb-x64/stable -o ~/Downloads/code.deb
    dpkg -i ~/Downloads/code.deb
    rm ~/Downloads/code.deb
fi