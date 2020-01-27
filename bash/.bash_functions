# Generate a new PS1.
_prompt() {
    PS1="\A "

    # kubectl information.
    if kube_ps1 > /dev/null; then
        PS1="${PS1}$(kube_ps1)"

        if [[ $(kube_ps1) != "" ]]; then
            PS1="$PS1 "
        fi
    fi
    
    PS1="${PS1}\e[34m\]\u \e[33m\]\w \[\e[97m\]"
    
    # git related information.
    if [ -f "$HOME/.git-prompt.sh" ]; then
        PS1="$PS1$(__git_ps1 "\e[32mgit:[%s]\[\e[97m\]")"
    fi
    
    PS1="${PS1}\n$ " 
}

# Add a fire emoji if you are using a cluster with PRD in its name.
check_kube_cluster() {
    CLUSTER="$1"

    if [[ "$1" == *"prd"* || "$1" == *"PRD"* ]]; then
        CLUSTER="🔥 $CLUSTER"
    fi
    
    echo $CLUSTER
}

