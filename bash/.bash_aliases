# Juniper VPN
alias vpn-start='vpn_start'
alias vpn-stop='sudo kill $(pgrep openconnect)'

# Docker
alias docker-clean='docker rm $(docker ps -a -q) && docker rmi $(docker images -q)'

# Python
alias python=python3

# Quirks
alias reset-touchpad='sudo modprobe -r psmouse && sudo modprobe psmouse proto=imps'

