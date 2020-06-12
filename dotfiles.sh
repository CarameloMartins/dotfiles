#!/bin/bash

# dotfiles.sh
# 
# caramelomartins' dotfiles for MacOS and Linux. 
# 
# This script allows for the management of dotfiles for MacOs and Linux, plus some setup commands for new machines 
# in both OSes. Additionally, it adds the script to your path and a bunch of administrative commands to facilitate 
# the management of dotfiles and machine configuration.

set -e

DOTFILES_DIR=$HOME/.dotfiles

. "$DOTFILES_DIR/scripts/utils.sh"

OPTIONS_SYMLINK=0
OPTIONS_INSTALL=0
OPTIONS_UPDATE=0
OPTIONS_CLEANUP=0
OPTIONS_WORKFLOW=0
OPTIONS_REPOS=0

#
# Requirements
#
if ! command -v stow > /dev/null; then
    echo "stow is missing. Please install stow."
fi

if ! command -v git > /dev/null; then
    echo "git is missing. Please install git."
fi

if ! command -v curl > /dev/null; then
    echo "curl is missing. Please install curl."
fi

#
# Parse Flags
#
if [ "$#" -gt 0 ]; then
    while test $# -gt 0; do
        case "$1" in
            -h|--help)
                echo "caramelomartins' dotfiles for MacOS and Linux"
                echo ""
                echo "Usage: ./dotfiles.sh [options] [commands]"
                echo ""
                echo "commands:"
                echo "  update            update git repository of dotfiles"
                echo "  edit              edit dotfiles.sh"
                echo "  status            show current status of git repository"
                echo "  install           install software and update necessary installation files"
                echo "  issue             open an issue in dotfiles Github repository"
                echo ""           
                echo "options:"
                echo "  -h, --help        show help"
                echo "  -a, --all         do everything dotfiles.sh can do"
                echo "  -c, --cleanup     cleanup with package manager"
                echo "  -i, --install     install software"
                echo "  -r, --repos       clone all of caramelomartins' publics repo"
                echo "  -s, --symlink     symlink files to $HOME"
                echo "  -u, --update      update installed software"
                echo "  -w, --workflow    configure UI and workflow stuff"
                echo ""
                echo "notes:" 
                echo "  - repos are only cloned if called explicitly."
                echo "  - options are only relevant when you run the script without a command."
                exit 0
                ;;
            -a|--all)
                OPTIONS_SYMLINK=1
                OPTIONS_INSTALL=1
                OPTIONS_UPDATE=1
                OPTIONS_CLEANUP=1
                OPTIONS_WORKFLOW=1
                shift
                ;;
            -c|--cleanup)
                OPTIONS_CLEANUP=1
                shift
                ;;
            -i|--install)
                OPTIONS_INSTALL=1
                shift
                ;;
            -r|--repos)
                OPTIONS_REPOS=1
                shift
                ;;
            -s|--symlink)
                OPTIONS_SYMLINK=1
                shift
                ;;
            -u|--update)
                OPTIONS_UPDATE=1
                shift
                ;;
            -w|--workflow)
                OPTIONS_WORKFLOW=1
                shift
                ;;
            update)
                cd "$DOTFILES_DIR" || exit 1
                git pull origin master || { echo "couldn't update repository from remote"; exit 1; }
                exit 0
                ;;
            edit)
                nvim "$DOTFILES_DIR/dotfiles.sh" || exit 1
                exit 0
                ;;
            status)
                cd "$DOTFILES_DIR" || exit 1
                git status || exit 1
                exit 0
                ;;
            install)
                shift
                FILE=$1
                shift
                
                install "$@" || { echo "couldn't execute '$@'"; exit 1; }
                echo "install $@" >> "$DOTFILES_DIR/install/$FILE.sh"
                exit 0
                ;;
            issue)
                if ! command -v hub > /dev/null; then
                    echo "hub is not currently installed."
                    exit 1
                fi

                cd "$DOTFILES_DIR" || exit 1
                hub issue create || exit 1
                exit 0
                ;;
            *)
                echo "Option \"$1\" not recognized, please use an existing option. Aborting."
                exit 1
                ;;
        esac
    done
else
    echo "No options selected, running with \"--all\"."
    OPTIONS_SYMLINK=1
    OPTIONS_INSTALL=1
    OPTIONS_UPDATE=1
    OPTIONS_CLEANUP=1
    OPTIONS_WORKFLOW=1
fi  

if [ $EUID != 0 ]; then
    sudo bash -c "echo \"Running script as $USER with root permissions.\""
fi

print_section "Starting dotfiles.sh..."

echo "Distribution: $(uname) $(uname -r)."
OS_NAME=$(uname)

cd "$DOTFILES_DIR" || exit 1

#
# Symlink with stow.
#
if [ "$OPTIONS_SYMLINK" -eq "1" ]; then
    print_section "Symlinks"

    execute "rm -f $HOME/.bashrc"
    execute "rm -f $HOME/.profile"

    execute "stow -v bash/ -t $HOME"
    execute "stow -v git/ -t $HOME"
    execute "stow -v ssh/ -t $HOME"
    execute "stow -v tmux/ -t $HOME"
    execute "stow -v vim/ -t $HOME"

    if [[ "$OS_NAME" == "Linux" ]]; then
        mkdir -p "$HOME/.config/Code/User"
        execute "stow -v -t $HOME/.config/Code/User vscode/ --ignore=\"extensions\""
    else
        # this is a bit of hack because I couldn't get the escaping to work properly and stow was complaining.
        mkdir -p "$HOME/Library/Application Support/Code/User"
        APP_SUPPORT="$HOME/Library/Application Support/Code/User"
        stow -v -t "$APP_SUPPORT" vscode/ --ignore="extensions"
        echo -e "- \033[1;33m(stow -t $HOME/Library/Application Support/ vscode/ --ignore=\"extensions\")\033[0m ✓"
    fi

    mk_dir "$HOME/.local/bin"
    execute "stow -v bin/ -t $HOME/.local/bin/"
    
    if command -v asdf > /dev/null; then
        mk_dir "$HOME/.asdf"
    fi

    mk_dir "$HOME/.kube/profiles/"
fi

#
# Update
#

if [ "$OPTIONS_UPDATE" -eq "1" ]; then
    print_section "Update"

    if [[ "$OS_NAME" == "Darwin" ]]; then
        execute "brew upgrade"
    else
        execute "sudo apt -y --fix-broken install"
        execute "sudo apt -qq update"
        execute "sudo apt -qq -y upgrade"
    fi
fi

#
# Installing Software
#

if [ "$OPTIONS_INSTALL" -eq "1" ]; then
    print_section "Installing Software"

    if [ "$OS_NAME" == "Darwin" ]; then
        . "$DOTFILES_DIR/install/macos.sh"
    else
        . "$DOTFILES_DIR/install/sources.sh"
        . "$DOTFILES_DIR/install/linux.sh"
    fi

    . "$DOTFILES_DIR/install/common.sh"

    print_section "Remove"

    if [[ "$OS_NAME" == "Darwin" ]]; then
        # TODO Automate removal of apps in MacOs.
        echo "- MacOS has no support for removing Applications."
    else
        remove thunderbird
    fi

    print_section "Manual"

    echo "- kotlinc"
    echo "- gradle"
    echo "- dbeaver"
fi

if [ "$OPTIONS_CLEANUP" -eq "1" ]; then
    print_section "Cleanup"

    if [[ "$OS_NAME" == "Darwin" ]]; then
        execute "brew cleanup"
    else
        execute "sudo apt -qq -y autoremove"
    fi
fi

#
# VSCode Extensions
#

if [ "$OPTIONS_INSTALL" -eq "1" ] || [ "$OPTIONS_UPDATE" -eq "1" ]; then 
    print_section "VSCode Extensions"
    
    if ! command -v code > /dev/null; then
        # ~/.bashrc adds this command to PATH in MacOS so if the command is not there,
        # that's probably because ~/.bashrc hasn't been loaded yet.
        . "$DOTFILES_DIR/bash/.bashrc"
    fi

    if command -v code > /dev/null; then
        uninstall=$(diff -u <(code --list-extensions) <(cat "$DOTFILES_DIR/vscode/extensions"))
        install=$(diff -u <(code --list-extensions) <(cat "$DOTFILES_DIR/vscode/extensions"))

        echo "U: $(echo "$uninstall" | grep -c -E "^\-[^-]"). I: $(echo "$uninstall" | grep -c -E "^\+[^+]")."

        echo "$uninstall" | grep -E "^\-[^-]" | sed -e "s/-//" | while read -r line; do
            execute "code --uninstall-extension $line"
        done

        echo "$install" | grep -E "^\+[^+]" | sed -e "s/+//" | while read -r line; do
            execute "code --install-extension $line"
        done
    else
        echo "- 'code' doesn't seem to exist in your PATH."
    fi
fi

#
# Desktop
# 

if [ "$OPTIONS_WORKFLOW" -eq "1" ]; then
    print_section "Customizing Desktop"

    if [[ "$OS_NAME" != "Darwin" ]]; then
        execute "rm_dir $HOME/examples.desktop"

        execute "rm_dir $HOME/Documents/" 
        execute "rm_dir $HOME/Music/" 
        execute "rm_dir $HOME/Pictures/" 
        execute "rm_dir $HOME/Public/" 
        execute "rm_dir $HOME/Templates/" 
        execute "rm_dir $HOME/Videos/"
    fi

    execute "mk_dir $HOME/Projects/"
fi

#
# Repos
#

if [ "$OPTIONS_REPOS" -eq "1" ]; then
    print_section "Clone Repos"

    http https://api.github.com/users/caramelomartins/repos | jq .[].ssh_url | while read -r line; do
        name=$(echo "$line" | sed -e 's/"git@github.com:caramelomartins\///' | sed -e 's/.git"//')
        line=$(echo "$line" | tr -d '"')

        if [ "$name" != "dotfiles" ]; then
            git_clone "$line" "$HOME/Projects/$name"
        fi
    done
fi

#
# Workflow
#

if [ "$OPTIONS_WORKFLOW" -eq "1" ]; then
    print_section "Customize Workflow"
    
    execute "nvim +PlugInstall +qall"
    source /dev/stdin <<<"$(gopass completion bash)"
    echo -e "- \033[1;33m(gopass completion bash)\033[0m ✓"
    
    if [[ "$OS_NAME" != "Darwin" ]]; then
        execute "sudo update-alternatives --set editor /usr/bin/nvim"
    fi

    if [[ ! -h $HOME/.local/bin/dotfiles ]]; then
        execute "ln -s $DOTFILES_DIR/dotfiles.sh $HOME/.local/bin/dotfiles"
    fi
    
    if [[ "$OS_NAME" == "Darwin" ]]; then
        COMPLETION_PREFIX="/usr/local"
    fi
    
    if [ "$OS_NAME" == "Darwin" ] && [ ! -f "$COMPLETION_PREFIX/etc/bash_completion.d/git-completion.bash" ]; then
        execute "curl -s https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o $COMPLETION_PREFIX/etc/bash_completion.d/git-completion.bash"
    fi

    if [ ! -f "$HOME/.git-prompt.sh" ]; then
        execute "curl -s https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh -o $HOME/.git-prompt.sh"
    fi
fi

print_section "Finished dotfiles.sh..."

figlet "Happy Hacking!"
