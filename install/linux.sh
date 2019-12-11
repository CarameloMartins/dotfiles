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

install clone tfenv https://github.com/tfutils/tfenv.git ~/.tfenv
install clone asdf https://github.com/asdf-vm/asdf.git ~/.asdf

install tar k9s https://github.com/derailed/k9s/releases/download/0.7.13/k9s_0.7.13_Linux_x86_64.tar.gz

install bash dir papirus-icon-theme /usr/share/icons/Papirus https://raw.githubusercontent.com/PapirusDevelopmentTeam/papirus-icon-theme/master/install.sh

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
