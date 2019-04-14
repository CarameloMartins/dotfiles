
rm_file() {
    if [ -f $1 ]; then
        echo "Removing $1..."
        rm $1
    fi
}

rm_dir() {
    if [ -d $1 ]; then
        echo "Removing $1..."
        rmdir $1
    fi
}

mk_dir(){
    if [ ! -d $1 ]; then
        echo "Creating $1..."
        mkdir $1
    fi
}

install_package(){
    # https://stackoverflow.com/questions/1298066/check-if-an-apt-get-package-is-installed-and-then-install-it-if-its-not-on-linu
    PKG_OK=$(dpkg-query -W --showformat='${Status}\n' $1 | grep "install ok installed")
    if [ "" == "$PKG_OK" ]; then
        echo "Installing $1..."
        sudo apt -qq --yes install $1
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