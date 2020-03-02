#!/usr/bin/env bash

# macos.sh
#
# Install software that is only installed on MacOS-based machines.

install asdf
install bash
install coreutils
install docker
install docker-compose
install findutils
install gawk
install gnu-sed
install gnu-tar
install gnupg
install gnutls
install gopass
install kubernetes-cli
install libyaml
install node
install php
install postgres
install python
install tfenv
install hugo
install watch
install yarn
install reattach-to-user-namespace

install cask spotify
install cask visual-studio-code
install cask keybase
install cask iterm2
install cask firefox
install cask 1password
install cask 1password-cli
install kotlin
install hub
install cask java
install gradle
install ktlint
install cask intellij-idea-ce
install minikube
install kube-ps1

if ! command -v k9s > /dev/null; then
    homebrew install derailed/k9s/k9s
fi
