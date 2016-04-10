#!/usr/bin/env bash
#
# Bootstrap a machine to run installation script.

git clone https://github.com/caramelomartins/dotfiles.git
./dotfiles/script/setup.sh
./dotfiles/script/dotfiles.sh

##
# Self deleting shell script.
# Source:
#   http://stackoverflow.com/questions/8981164/self-deleting-shell-script
##
rm -- "$0"
