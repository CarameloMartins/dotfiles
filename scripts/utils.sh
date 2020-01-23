#!/usr/bin/env bash

# utils.sh
#
# Helper functions that are used in th execution of all the scripts.

install(){
    PKG_NAME=$1
    if [ "$1" = "deb" ]; then
        PKG_NAME=$2
        PKG_URL=$3
        if ! command -v "$PKG_NAME" > /dev/null; then
            curl -L "$PKG_URL" -o "$HOME/Downloads/$PKG_NAME.deb"
            sudo dpkg -i "$HOME/Downloads/$PKG_NAME.deb"
            rm "$HOME/Downloads/$PKG_NAME.deb"
            sudo apt --fix-broken install -y
        fi
    elif [ "$1" = "bin" ]; then
        PKG_NAME=$2
        PKG_URL=$3

        if ! command -v "$PKG_NAME" > /dev/null; then
            sudo curl -L "$PKG_URL" -o "/usr/local/bin/$PKG_NAME"
            sudo chmod +x "/usr/local/bin/$PKG_NAME"
        fi
    elif [ "$1" = "clone" ]; then
        PKG_NAME=$2
        PKG_URL=$3
        TARGET=$4

        if [ ! -d "$TARGET" ]; then
            git clone "$PKG_URL" "$TARGET"
        fi
    elif [ "$1" = "tar" ]; then
        PKG_NAME=$2
        PKG_URL=$3
        PKG_PATH=$4

        if ! command -v "$PKG_NAME" > /dev/null; then
            curl -L "$PKG_URL" -o "$HOME/Downloads/$PKG_NAME.tar.gz"
            tar -xzvf "$HOME/Downloads/$PKG_NAME.tar.gz" "$PKG_PATH$PKG_NAME"
            sudo mv "$PKG_PATH$PKG_NAME" "/usr/local/bin/$PKG_NAME"
            sudo chmod +x "/usr/local/bin/$PKG_NAME"
            rm -r "$HOME/Downloads/$PKG_NAME.tar.gz"

            if [ -n "$PKG_PATH" ]; then
                sudo rm -r "$(awk -F/ '{print $1}' <<< $PKG_PATH)"
            fi
        fi
    elif [ "$1" = "zip" ]; then
        PKG_NAME=$2
        PKG_URL=$3

        if ! command -v "$PKG_NAME" > /dev/null; then
            curl -L "$PKG_URL" -o "$HOME/Downloads/$PKG_NAME.zip"
            unzip "$HOME/Downloads/$PKG_NAME.zip" -d "$HOME/Downloads/$PKG_NAME"
            sudo mv "$HOME/Downloads/$PKG_NAME/$PKG_NAME" "/usr/local/bin/"
            sudo rm -r "$HOME/Downloads/$PKG_NAME" "$HOME/Downloads/$PKG_NAME.zip"
        fi
    elif [ "$1" = "bash" ] && [ "$#" -gt 2 ]; then
        PKG_NAME=$3

        if [ "$2" = "dir" ]; then
            TARGET=$4
            PKG_URL=$5

            if [ ! -d "$TARGET" ]; then
                curl -s -L "$PKG_URL" | bash
            fi
        else
            PKG_URL=$4
            if ! command -v "$PKG_NAME" > /dev/null; then
                curl -s -L "$PKG_URL" | bash
            fi
        fi
    elif [[ "$(uname)" == Darwin ]]; then
        if [ "$1" = "cask" ]; then
            PKG_NAME=$2
            PKG_OK=$(brew cask list | grep "$PKG_NAME")
            if [ "" = "$PKG_OK" ]; then
                brew cask install "$PKG_NAME"
            fi
        else
            PKG_OK=$(brew list | grep "$PKG_NAME")
            if [ "" = "$PKG_OK" ]; then
                brew install "$PKG_NAME"
            fi
        fi
    else
        PKG_OK=$(dpkg-query -W -f='${Status}' "$PKG_NAME" 2>/dev/null | grep -c "install ok installed" || echo "0")
        if [[ "0" -eq "$PKG_OK" ]]; then
            echo "Installing $PKG_NAME..."
            sudo apt -qq --yes install "$PKG_NAME"
        fi
    fi
    
    echo -e "- \033[01;33m$PKG_NAME\033[00m ✓"
}

remove(){
    # https://stackoverflow.com/questions/1298066/check-if-an-apt-get-package-is-installed-and-then-install-it-if-its-not-on-linu
    PKG_OK=$(dpkg-query -W -f='${Status}' "$PKG_NAME" 2>/dev/null | grep -c "install ok installed" || echo "0")
    if [ "1" -eq "$PKG_OK" ]; then
        echo "Uninstalling $1..."
        sudo apt -qq --yes remove "$1"
    fi

    echo -e "- rm \033[1;33m$1\033[0m ✓"
}

print_section() {
    echo -e "\033[4;1;32m> $1\033[0m"
}

print_subsection() {
    echo -e "\033[4;1;34m$1\033[0m"
}

print_execution() {
    echo -e "- \033[1;33m$1\033[0m ✓"
}

execute() {   
    if ! $1; then
        echo "Failed to execute command: \"$1\"."
        exit
    fi

    echo -e "- \033[1;33m($1)\033[0m ✓"
}

rm_file() {
    if [ -f "$1" ]; then
        execute "rm $1"
    else
        print_execution "rm $1"
    fi
}

rm_dir() {
    if [ -d "$1" ]; then
        execute "rmdir $1"
    else
        print_execution "rmdir $1"
    fi
}

mk_dir(){
    if [ ! -d "$1" ]; then
        execute "mkdir -p $1"
    else
        print_execution "mkdir -p $1"
    fi
}

git_clone(){
    if [ ! -d "$2" ]; then
        execute "git clone -q $1 $2"
    else
	print_execution "repo $2"
    fi
}
