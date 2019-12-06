OS=$(uname)

# Juniper VPN
alias vpn-start='vpn_start'
alias vpn-stop='sudo kill $(pgrep openconnect)'

# Docker
alias docker-clean='docker rm $(docker ps -a -q) && docker rmi $(docker images -q)'

# Quirks
if [[ $OS != "Darwin" ]]; then
    # Quick workaround for when Ubuntu's touchpad randomly stops working.
    alias reset-touchpad='sudo modprobe -r psmouse && sudo modprobe psmouse proto=imps'
fi

# Directory Iteration
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

# Listing
if [[ $OS == "Darwin" ]]; then
    alias ls="ls -G"
    alias ll="ls -G -al"
else
    alias ls="ls --color=auto"
    alias ll="ls --color -al"
fi

# Security
alias sha1='openssl sha1'

# Networking
alias ping='ping -c 5'

# Maintenance
alias apt="sudo apt"
alias update="sudo apt update && sudo apt upgrade"

# System
alias df='df -H'
alias du='du -ch'
alias top='htop'

# Tmux
alias tkill='tmux kill-server'

# nvim
alias vim='nvim'
