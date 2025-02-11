#!/bin/bash
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
*i*) ;;
*) return ;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-color | *-256color) color_prompt=yes ;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm* | rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*) ;;
esac

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

# load inputrc
[ -f "$HOME/.inputrc" ] && bind -f "$HOME/.inputrc"

# load locations variables
[ -f "$HOME/.scripts/locations.sh" ] && source "$HOME/.scripts/locations.sh"

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
[ -f "$ALIASES" ] && source "$ALIASES"

# JAVA
CHECKSTYLE_PATH="/usr/lib/jvm/lib/checkstyle.jar"
JUNIT_PATH="/usr/lib/jvm/lib/junit4.jar"
PLANTUML_PATH="/usr/lib/jvm/lib/plantuml-1.2024.8.jar"

source ~/.scripts/vpn7.sh

source ~/.scripts/prompt.sh
PROMPT_COMMAND='set_prompt $?' # single quotes for $? to be evaluated after last command

# NPM
export PATH="${HOME}/.npm/bin:$PATH"

# texlive path
export PATH="/usr/local/texlive/2024/bin/x86_64-linux:$PATH"
export MANPATH="/usr/local/texlive/2024/texmf-dist/doc/man:$MANPATH"
export INFOPATH="/usr/local/texlive/2024/texmf-dist/doc/info:$INFOPATH"

# adding deno path
export PATH="$HOME/.deno/bin:$PATH"

# opam init
source ~/.scripts/opam-init.sh

if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init --cmd cd bash)"
fi

# remove duplicates in PATH variable
export PATH="$(perl -e 'print join(":", grep { not $seen{$_}++ } split(/:/, $ENV{PATH}))')"
# remove duplicates in MANPATH variable
export MANPATH="$(perl -e 'print join(":", grep { not $seen{$_}++ } split(/:/, $ENV{MANPATH}))')"

# remove duplicates in INFOPATH variable
export INFOPATH="$(perl -e 'print join(":", grep { not $seen{$_}++ } split(/:/, $ENV{INFOPATH}))')"

# new ssh function to avoid nested tmux sessions
source ~/.scripts/tmux-ssh.sh

# define variable that holds current IP
export MY_IP=$(ip -4 addr show $(ip route show default | awk '/default/ {print $5}') | grep -oP '(?<=inet\s)\d+(\.\d+){3}')

# create tmux session on attach if existing
# if not in tmux, a session exists and the terminal is interactive
if [ -z "$TMUX" ] && [ -n "$PS1" ] && [ -t 1 ]; then
    # if a session exists, attach to it
    if tmux list-sessions 2>/dev/null | grep -q .; then
        tmux attach-session -t "$(tmux list-sessions -F '#S' | head -n 1)"
    else
        # if no session exists, create one, called 'default'
        tmux new -s default
    fi
fi

