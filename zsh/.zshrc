export ZSH=$HOME/.oh-my-zsh

# ohmyzsh configurations.
source $ZSH/oh-my-zsh.sh
ZSH_THEME="robbyrussell"
plugins=(git pyenv)

# Start TMUX when launching a new instance of zsh.
if [ "$TMUX" = "" ]; then tmux new; fi

if [ "$OS_NAME" = "Darwin" ]; then
    source /usr/local/opt/kube-ps1/share/kube-ps1.sh
else
    source "$HOME/.kube-ps1/kube-ps1.sh"
fi

if kube_ps1 > /dev/null; then
    KUBE_PS1_NS_ENABLE=0
    KUBE_PS1_CLUSTER_FUNCTION=check_kube_cluster
fi

PROMPT='$(kube_ps1)'$PROMPT