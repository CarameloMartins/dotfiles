
vpn_start () 
{
    if [ $# -eq 0 ]
    then
        ADDRESS=$VPN_ADDR
        USER=$VPN_USER
    else
        ADDRESS=$1
        USER=$2
    fi

    echo "Starting VPN to $ADDRESS for $USER."
    sudo openconnect --juniper "$ADDRESS" -qbu "$USER"
}