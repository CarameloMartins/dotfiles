if ! command -v nodejs > /dev/null; then
    curl -sL https://deb.nodesource.com/setup_11.x | sudo -E bash -
fi

if ! command -v kubectl > /dev/null; then
    sudo apt-get update && sudo apt-get install -y apt-transport-https
    curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
    echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
    sudo apt-get -qq update
fi

if ! command -v docker > /dev/null; then
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
fi   

if ! command -v typora > /dev/null; then
        sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys BA300B7755AFCFAE
    sudo add-apt-repository 'deb https://typora.io/linux ./'
    sudo apt update
fi

if ! command -v tlp > /dev/null; then
    add-apt-repository ppa:linrunner/tlp
fi

if ! command -v spotify > /dev/null; then
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 931FF8E79F0876134EDDBDCCA87FF9DF48BF1C90
    echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list
fi

if ! command -v peek > /dev/null; then
    sudo add-apt-repository -y ppa:peek-developers/stable
    sudo apt update
fi

if ! command -v code > /dev/null; then
    curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
    mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
    sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
    rm microsoft.gpg
fi
