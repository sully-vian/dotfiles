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
    _warn() { notify-send -u critical "Shell Error" "$1"; echo -e "${RED}Error: $1${NC}" >&2; }
else
    _warn() { echo -e "${RED}Error: $1${NC}" >&2; }
fi

require() {
    for cmd in "$@"; do
        if ! command -v "$cmd" > /dev/null 2>&1; then
            _warn "Required command '$cmd' is missing."
        fi
    done
}

# Core utiliies
require ls grep du find xdg-open curl

# --- Color Support ---
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  alias diff='diff --color=always'
  alias dir='dir --color=auto'
  alias vdir='vdir --color=auto'
  alias grep='grep --color=auto'   # doesn't support regex
  alias fgrep='fgrep --color=auto' # supports extended regex
  alias egrep='egrep --color=auto' # doesn't support regex
  alias less='less -R'
fi

# --- Navigation & Listing ---
alias ..="cd .."
alias ...="cd ../.."
alias ll='ls -AlF'
alias la='ls -A'

# -- Modern replacements ---
require lsd bat onefetch inxi fd zoxide
alias ls='lsd --group-directories-first'
alias onefetch='onefetch --nerd-fonts'
alias specs="inxi -Faz"
alias fd="fd --hidden" # include hidden files and directories
eval "$(zoxide init --cmd cd bash)"


# --- Programming ---
require gnatmake javac java clang clang++
alias adc="gnatmake -f -gnatwa -gnata -g"
function adc-e() { adc "$1" && ./"${1%.*}"; } # compile and execute ada program

alias javaclean="find . -name \"*.class\" | xargs rm -f" # remove all .class files
alias javacall="javac *.java"                        # compile all .java files
function javac-e() { javac "$1" && java "${1%.*}"; } # compile and execute java program
function javatest-c() { javac "$1" && java org.junit.runner.JUnitCore "${1%.*}"; } # compile and run JUnit test

alias clang="clang -fcolor-diagnostics"
alias clang++="clang++ -fcolor-diagnostics"

# --- Editors & Git ---
require nvim lazygit
alias nv="nvim"
alias vim="nvim"
function v() {
    if [ $# -eq 0 ]; then nvim .; else nvim "$@"; fi
}
alias lg="lazygit"
alias edot="cd ~/dotfiles && v . && cd -"

# --- Utilities ---
require trans mpv
alias c="clear"
alias shut="shutdown now"
alias chut="shut"
alias open="xdg-open"
alias trans="trans -brief"
alias mpv="mpv --no-border"
alias mpv-webcam="~/.scripts/mpv-webcam.sh"
function cht() { curl -s cheat.sh/$1 | less; }

# show sorted disk usage
function usage() {
	du -sh "$@" | sort -hr
}

# --- Pywal Integration ---
if [ -f "$HOME/.cache/wal/colors.sh" ]; then
    source "$HOME/.cache/wal/colors.sh"
    alias dmenu="dmenu -nf \"$color15\" -nb \"$color0\" -sf \"$color15\" -sb \"$color1\""
fi

# --- Alert Alias (long commands) ---
# sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'



