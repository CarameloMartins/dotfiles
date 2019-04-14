. ./utils.sh

install_package gnome-shell-extensions
install_package gnome-tweaks
install_package arc-theme

if [ ! -d ~/.local/share/gnome-shell/extensions/dash-to-dock@micxgx.gmail.com ]; then
    
    echo "Installing Gnome Shell System Monitor..."
    install_package gir1.2-gtop-2.0 
    install_package gir1.2-networkmanager-1.0  
    install_package gir1.2-clutter-1.0

    git clone git://github.com/paradoxxxzero/gnome-shell-system-monitor-applet.git
    cd gnome-shell-system-monitor-applet
    make install
    cd ..
    rm -r gnome-shell-system-monitor-applet
fi

if [ ! -d ~/.local/share/gnome-shell/extensions/system-monitor@paradoxxx.zero.gmail.com ]; then
    echo "Installing Dash to Dock..."

    git clone https://github.com/micheleg/dash-to-dock.git
    cd dash-to-dock
    make
    make install
    cd ..
    rm -r dash-to-dock
fi

if [ ! -d /usr/share/icons/Papirus ]; then
    echo "Installing Papirus Icons..."
    wget -qO- https://raw.githubusercontent.com/PapirusDevelopmentTeam/papirus-icon-theme/master/install.sh | sh
fi 