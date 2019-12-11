#!/bin/bash

. scripts/utils.sh

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

#
# Parse Flags
#
if [ "$#" -gt 0 ]; then
    while test $# -gt 0; do
        case "$1" in
            -h|--help)
                echo "caramelomartins' dotfiles for MacOS and Linux"
                echo ""
                echo "Usage: ./dotfiles.sh [options]"
                echo ""
                echo "options:"
                echo "-h, --help        show help"
                echo "-a, --all         do everything dotfiles.sh can do"
                echo "-c, --cleanup     cleanup with package manager"
                echo "-i, --install     install software"
                echo "-r, --repos       clone all of caramelomartins' publics repo"
                echo "-s, --symlink     symlink files to $HOME"
                echo "-u, --update      update installed software"
                echo "-w, --workflow    configure UI and workflow stuff"
                echo ""
                echo "note: repos are only cloned if called explicitly."
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

#
# Symlink with stow.
#
if [ "$OPTIONS_SYMLINK" -eq "1" ]; then
    print_section "Symlinks"

    execute "rm -f $HOME/.bashrc"
    execute "rm -f $HOME/.profile"

    execute "stow bash/"
    execute "stow git/"
    execute "stow ssh/"
    execute "stow tmux/"
    execute "stow vim/"

    if [[ "$OS_NAME" == "Linux" ]]; then
        execute "stow -t $HOME/.config/ vscode/ --ignore=\"extensions\""
    else
        # this is a bit of hack because I couldn't get the escaping to work properly and stow was complaining.
        APP_SUPPORT="$HOME/Library/Application Support/"
        stow -t "$APP_SUPPORT" vscode/ --ignore="extensions"
        echo -e "- \033[1;33m(stow -t $HOME/Library/Application Support/ vscode/ --ignore=\"extensions\")\033[0m ✓"
    fi

    mk_dir "$HOME/.local/bin"
    execute "stow bin/ -t $HOME/.local/bin/"
    
    if command -v asdf > /dev/null; then
        mk_dir "$HOME/.asdf"
    fi
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
        . install/macos.sh
    else
        . install/sources.sh
        . install/linux.sh
    fi

    . install/common.sh

    print_section "Remove"

    if [[ "$OS_NAME" == "Darwin" ]]; then
        # TODO Automate removal of apps in MacOs.
        echo "- MacOS has no support for removing Applications."
    else
        remove thunderbird*
        remove libreoffice*
    fi
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
        . bash/.bashrc
    fi

    if command -v code > /dev/null; then
        uninstall=$(diff -u <(code --list-extensions) <(cat vscode/extensions))
        install=$(diff -u <(code --list-extensions) <(cat vscode/extensions))

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
        rm_file ~/examples.desktop

        rm_dir ~/Documents/ 
        rm_dir ~/Music/ 
        rm_dir ~/Pictures/ 
        rm_dir ~/Public/ 
        rm_dir ~/Templates/ 
        rm_dir ~/Videos/
    fi

    mk_dir ~/Projects/
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

if [ "$OPTIONS_WORKFLOW" -eq "1" ]; then
    print_section "Customize Workflow"
    
    execute "nvim +PlugInstall +qall"
    source /dev/stdin <<<"$(gopass completion bash)"
    echo -e "- \033[1;33m(gopass completion bash)\033[0m ✓"
    
    if [[ "$OS_NAME" != "Darwin" ]]; then
        execute "sudo update-alternatives --set editor /usr/bin/nvim"
    fi
fi

print_section "Finished dotfiles.sh..."

figlet "Happy Hacking!"
