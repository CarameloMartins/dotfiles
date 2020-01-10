# read a markdown files in terminal
mdr () {
    pandoc $1 | lynx --stdin
}

_prompt() {
    PS1=""

    # kubectl information.
    if kube_ps1 > /dev/null; then
        PS1="$(kube_ps1) "
    fi

    PS1="${PS1}\[\e[33m\]\u \[\e[97m\]in \[\e[34m\]\w \[\e[97m\]"
    
    # git related information.
    if [ -f "$HOME/.git-prompt.sh" ]; then
        PS1="$PS1$(__git_ps1 "on \e[35m%s\[\e[97m\]")"
    fi

    PS1="$PS1\n$ " 
}

check_kube_cluster() {
    CLUSTER="$1"

    if [[ "$1" == *"prd"* || "$1" == *"PRD"* ]]; then
        CLUSTER="🔥 $CLUSTER"
    fi
    
    echo $CLUSTER
}
