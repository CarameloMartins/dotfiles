#!/bin/zsh

OS_NAME="$(uname)"

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8 

# Start TMUX when launching a new instance of zsh.
if [ -z "$TMUX" ]
then
    tmux attach -t TMUX || tmux new -s TMUX
fi

# Load auxiliary files.
source "$HOME/.zsh_functions"
source "$HOME/.aliases"

# ohmyzsh configurations.
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="robbyrussell"
plugins=(git pyenv)

source $ZSH/oh-my-zsh.sh

# kube-ps1.sh
if [ "$OS_NAME" = "Darwin" ]; then
    source /usr/local/opt/kube-ps1/share/kube-ps1.sh
else
    source "$HOME/.kube-ps1/kube-ps1.sh"
fi

if kube_ps1 > /dev/null; then
    KUBE_PS1_NS_ENABLE=0
    KUBE_PS1_CLUSTER_FUNCTION=check_kube_cluster
fi

# kubectl 
export KUBECONFIG="$HOME/.kube/config"

if [ -d "$HOME/.kube/profiles/" ]; then
    if [ "$(ls -A $HOME/.kube/profiles/)" ]; then
        for FILE in "$HOME"/.kube/profiles/*
        do
            export KUBECONFIG="$KUBECONFIG:$FILE"
        done
    fi
fi

# nvm
export NVM_DIR="$HOME/.nvm"
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"

# Composer
export PATH="$PATH:$HOME/.composer/vendor/bin"

# PHPBrew
if command -v phpbrew > /dev/null; then
	[[ -e ~/.phpbrew/bashrc ]] && source ~/.phpbrew/bashrc
fi

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

if command -v pyenv 1>/dev/null 2>&1; then
      eval "$(pyenv init -)"
fi

if [[ ! -d "$(pyenv root)/plugins/pyenv-virtualenv" ]]; then
    eval "$(pyenv virtualenv-init -)"
fi

[[ -s "/home/hmartins/.gvm/scripts/gvm" ]] && source "/home/hmartins/.gvm/scripts/gvm"

# gvm
[[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"

# tfenv
export PATH="$HOME/.tfenv/bin:$PATH"

# GPG Signing
export GPG_TTY=$(tty)

# Editor
export VISUAL=nvim
export EDITOR="$VISUAL"

[[ ":$PATH:" != *":$HOME/.local/bin:"* ]] && PATH="$HOME/.local/bin:${PATH}"

if type brew &>/dev/null; then
  HOMEBREW_PREFIX="$(brew --prefix)"
  if [[ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]]; then
    source "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
  else
    for COMPLETION in "${HOMEBREW_PREFIX}/etc/bash_completion.d/"*; do
      [[ -r "$COMPLETION" ]] && source "$COMPLETION"
    done
  fi
fi

# Customize prompt for zsh.
PROMPT='$(kube_ps1) '$PROMPT
