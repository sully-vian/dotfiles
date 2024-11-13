#!/bin/bash

# custom prompt
set_prompt() {
  
  # variables
  BLUE="\[\e[34m\]"
  WHITE="\[\e[0m\]"

  RED1="\[\e[1;31m\]"
  RED0="\[\e[0;31m\]"
  RED2="\[\e[2;31m\]"

  GREEN1="\[\e[1;32m\]"
  GREEN0="\[\e[0;32m\]"
  GREEN2="\[\e[2;32m\]"

  BOLD="\[\e[1m\]"
  RESET="\[\e[0m\]"

  arrow="➜"

  lastcommand=$1

    # get absolute path of git root
    git_root_path=$(git rev-parse --show-toplevel 2>/dev/null)

    if [ -n "$git_root_path" ]; then
        # if inside git repo, display path from root of git repo
        # git_root = git repo name
        git_root=$(basename "$git_root_path")

        if [ "$git_root_path" = "$PWD" ]; then
            # if at root of git repo
            if [ "$git_root" = "n7-files" ]; then
                rel_path="${BOLD}N7"
            else
                rel_path="📚 $git_root"
            fi
        elif [ "$git_root" = "n7-files" ]; then
            rel_path="${BOLD}N7${RESET} ${RED0}${PWD#"$git_root_path/"}"
        else
            # just get the relative git filepath
            rel_path="📚 $git_root/${PWD#"$git_root_path/"}"
        fi
    else
        case $PWD in
        /) rel_path="🪵" ;;
        "$HOME"/.local/share/Trash*) rel_path="🗑️ ${PWD#"$HOME/.local/share/Trash"}" ;;
        "$HOME"/.config*) rel_path="⚙️ ${PWD#"$HOME/.config"}" ;;
        "$HOME"/Desktop*) rel_path="🖥️ ${PWD#"$HOME/Desktop"}" ;;
        "$HOME"/Downloads*) rel_path="📥${PWD#"$HOME/Downloads"}" ;;
        "$HOME"/Documents*) rel_path="📄${PWD#"$HOME/Documents"}" ;;
        "$HOME"/Music*) rel_path="🎵${PWD#"$HOME/Music"}" ;;
        "$HOME"/Videos*) rel_path="🎞️ ${PWD#"$HOME/Videos"}" ;;
        "$HOME"/Pictures*) rel_path="📷${PWD#"$HOME/Pictures"}" ;;
        "$HOME"*) rel_path="🏠${PWD#"$HOME"}" ;;
        *) rel_path="📁 \w" ;;
        esac
    fi

    PS1="┌[${BLUE}\u${WHITE}@\h:${RED0}$rel_path${WHITE}]\n└─"
    PS1="$rel_path"

    if [ "$lastcommand" -eq 0 ]; then
        coloredarrow="${GREEN1}$arrow ${RESET}"
    else
        coloredarrow="${RED1}$arrow ${RESET}"
    fi

    PS1="$PS1\n$coloredarrow"

    if [ -n "$SSH_CONNECTION" ]; then
      PS1="[📡] $PS1"
    fi

    if pgrep vpnc >/dev/null; then
      PS1="[🌐] $PS1"
    fi
}
