#!/usr/bin/env bash

# print the prompt string (with \[ \] and \e escapes, unexpanded)
# test with: p=$(build_prompt 0); echo "${p@P}"
build_prompt() {

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
  local SHOW_CURSOR="\[\e[?25h\]"

  local lastcommand=$1

  # get absolute path of git root
  local git_root_path
  git_root_path=$(git rev-parse --show-toplevel 2>/dev/null)

  if [ -n "$git_root_path" ]; then
    # if inside git repo, display path from root of git repo
    # git_root = git repo name
    local git_root=${git_root_path##*/}

    if [ "$git_root_path" = "$PWD" ]; then
      # if at root of git repo
      local rel_path="󰊢 $git_root"
    elif [ "$git_root" = "n7-files" ]; then
      local rel_path="${BOLD}N7${RESET} ${RED0}${PWD#"$git_root_path/"}"
    else
      # just get the relative git filepath
      local rel_path="󰊢 $git_root/${PWD#"$git_root_path/"}"
    fi
  else
    case $PWD in
    "$HOME"/.local/share/Trash*) local rel_path="󰩹 ${PWD#"$HOME/.local/share/Trash"}" ;;
    "$HOME"/.config*) local rel_path=" ${PWD#"$HOME/.config"}" ;;
    "$HOME"/Desktop*) local rel_path=" ${PWD#"$HOME/Desktop"}" ;;
    "$HOME"/Downloads*) local rel_path="󰉍 ${PWD#"$HOME/Downloads"}" ;;
    "$HOME"/Music*) local rel_path="󱍙 ${PWD#"$HOME/Music"}" ;;
    "$HOME"/Pictures*) local rel_path="󰉏 ${PWD#"$HOME/Pictures"}" ;;
    "$HOME"/Videos*) local rel_path=" ${PWD#"$HOME/Videos"}" ;;
    "$HOME"*) local rel_path="󰋜 ${PWD#"$HOME"}" ;;

    *) local rel_path="\w" ;;
    esac
  fi

  # colored path
  local prompt="${GREEN1}$rel_path${RESET}"

  local prompt_icon_color
  if [ "$lastcommand" -eq 0 ]; then
    prompt_icon_color="$GREEN1"
  else
    prompt_icon_color="$RED1"
  fi
  local prompt_icon="${prompt_icon_color}($lastcommand) "

  prompt="$prompt\n$prompt_icon${RESET}"

  if [ -n "$SSH_CONNECTION" ]; then
    prompt="󰣀 $prompt"
  fi
  printf '%s' "${RESET}${SHOW_CURSOR}$prompt"
}

# custom prompt, called from PROMPT_COMMAND
set_prompt() {
  PS1="$(build_prompt "$1")"
}
