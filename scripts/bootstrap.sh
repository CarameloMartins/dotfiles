#!/usr/bin/env bash
#
# Bootstrap a machine with dotfiles. This file is supposed to enable a "one-click"
# install for the dotfiles.

git clone https://github.com/caramelomartins/dotfiles.git
./dotfiles/scripts/install.sh
