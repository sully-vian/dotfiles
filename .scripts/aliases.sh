#!/usr/bin/env bash

# ==============================================================================
#                              ~/.bash_aliases
# ==============================================================================
# This file contains custom aliases and functions for the bash shell.
# It is sourced by the ~/.bashrc file.
#
# Add your custom aliases and functions below
# ==============================================================================

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

if command -v notify-send >/dev/null 2>&1; then
    _warn() {
        notify-send -u critical -t 10000 "Shell Error" "$1"
        echo -e "${RED}Error: $1${NC}" >&2
    }
else
    _warn() { echo -e "${RED}Error: $1${NC}" >&2; }
fi

require() {
    for cmd in "$@"; do
        if ! command -v "$cmd" >/dev/null 2>&1; then
            _warn "Required command '$cmd' is missing."
        fi
    done
}

# Core utiliies
require ls grep du find xdg-open curl

# --- Color Support ---
if [ -x /usr/bin/dircolors ]; then
    if test -r "$HOME/.dircolors"; then
        eval "$(dircolors -b "$HOME/.dircolors")"
    else
        eval "$(dircolors -b)"
    fi
    alias ls='ls --color=auto'
    alias diff='diff --color=always'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
fi

export LESS="--ignore-case --incsearch --RAW-CONTROL-CHARS --quit-if-one-screen" # enable incremental search by default
export MANPAGER="nvim +Man!"

# --- Navigation & Listing ---
alias ..="cd .."
alias ...="cd ../.."
alias -- -="cd -"
alias ll='ls -AlF'
alias la='ls -A'

# -- Modern replacements ---
require lsd bat onefetch inxi fd zoxide rg
alias ls='lsd --group-directories-first'
alias onefetch='onefetch --nerd-fonts'
alias specs="inxi -Faz"
alias fd="fd --hidden" # include hidden files and directories
eval "$(zoxide init --cmd cd bash)"
export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/ripgrep/config"

# --- Editors & Git ---
require nvim lazygit
alias vim="nvim"
alias lg="lazygit"
alias edot="v \$DOTFILES"

# --- Utilities ---
require trans mpv
alias c="clear"
alias shut="shutdown now"
alias chut="shut"
alias open="xdg-open"
alias trans="trans -brief"
alias mpv="mpv --no-border"

# show sorted disk usage
usage() {
    du -sh "$@" | sort -hr
}

# --- Pywal Integration ---
if [ -f "$HOME/.cache/wal/colors.sh" ]; then
    source "\$HOME/.cache/wal/colors.sh"
fi

# --- Alert Alias (long commands) ---
# sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
