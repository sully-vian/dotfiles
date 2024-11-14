#!/bin/bash

# custom prompt
set_prompt() {
  
  # variables
  local BLUE="\[\e[34m\]"
  local WHITE="\[\e[0m\]"
  
  local RED1="\[\e[1;31m\]"
  local RED0="\[\e[0;31m\]"
  local RED2="\[\e[2;31m\]"

  local GREEN1="\[\e[1;32m\]"
  local GREEN0="\[\e[0;32m\]"
  local GREEN2="\[\e[2;32m\]"

  local BOLD="\[\e[1m\]"
  local RESET="\[\e[0m\]"

  local arrow="➜"

  local lastcommand=$1

    # get absolute path of git root
  local  git_root_path=$(git rev-parse --show-toplevel 2>/dev/null)

    if [ -n "$git_root_path" ]; then
        # if inside git repo, display path from root of git repo
        # git_root = git repo name
        local git_root=$(basename "$git_root_path")

        if [ "$git_root_path" = "$PWD" ]; then
            # if at root of git repo
            if [ "$git_root" = "n7-files" ]; then
                local rel_path="${BOLD}N7"
            else
                local rel_path="📚 $git_root"
            fi
        elif [ "$git_root" = "n7-files" ]; then
            local rel_path="${BOLD}N7${RESET} ${RED0}${PWD#"$git_root_path/"}"
        else
            # just get the relative git filepath
            local rel_path="📚 $git_root/${PWD#"$git_root_path/"}"
        fi
    else
        case $PWD in
        /) local rel_path="🪵" ;;
        "$HOME"/.local/share/Trash*) local rel_path="🗑️ ${PWD#"$HOME/.local/share/Trash"}" ;;
        "$HOME"/.config*) local rel_path="⚙️ ${PWD#"$HOME/.config"}" ;;
        "$HOME"/Desktop*) local rel_path="🖥️ ${PWD#"$HOME/Desktop"}" ;;
        "$HOME"/Downloads*) local rel_path="📥${PWD#"$HOME/Downloads"}" ;;
        "$HOME"/Documents*) local rel_path="📄${PWD#"$HOME/Documents"}" ;;
        "$HOME"/Music*) local rel_path="🎵${PWD#"$HOME/Music"}" ;;
        "$HOME"/Videos*) local rel_path="🎞️ ${PWD#"$HOME/Videos"}" ;;
        "$HOME"/Pictures*) local rel_path="📷${PWD#"$HOME/Pictures"}" ;;
        "$HOME"*) local rel_path="🏠${PWD#"$HOME"}" ;;
        *) local rel_path="📁 \w" ;;
        esac
    fi

    PS1="┌[${BLUE}\u${WHITE}@\h:${RED0}$rel_path${WHITE}]\n└─"
    PS1="$rel_path"

    if [ "$lastcommand" -eq 0 ]; then
        local coloredarrow="${GREEN1}$arrow ${RESET}"
    else
        local coloredarrow="${RED1}$arrow ${RESET}"
    fi

    PS1="$PS1\n$coloredarrow"

    if [ -n "$SSH_CONNECTION" ]; then
      PS1="[📡] $PS1"
    fi

    if pgrep vpnc >/dev/null; then
      PS1="[🌐] $PS1"
    fi
}
