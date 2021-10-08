#!/usr/bin/env bash

# macos.sh
#
# Install software that is only installed on MacOS-based machines.

brew tap homebrew/cask-fonts
brew tap homebrew/cask-versions
install asdf
install bash
install cask 1password
install cask 1password-cli
install cask authy
install cask clockify
install cask docker
install cask font-fira-code
install cask intellij-idea-ce
install cask rectangle
install cask spotify
install cask virtualbox
install cask visual-studio-code
install aws-iam-authenticator
install coreutils
install fff
install findutils
install fzf
install gawk
install gnu-sed
install gnu-tar
install gnupg
install gnutls
install gopass
install gradle
install hub
install hugo
install kotlin
install ktlint
install kube-ps1
install kubernetes-cli
install libyaml
install make
install minikube
install node
install php
install postgres
install pyenv
install python
install reattach-to-user-namespace
install tfenv
install tree
install watch
install yarn

if ! command -v k9s > /dev/null; then
    brew install derailed/k9s/k9s
fi
