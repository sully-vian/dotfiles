#!/bin/bash

# ==============================================================================
#                              ~/.bash_aliases
# ==============================================================================
# This file contains custom aliases and functions for the bash shell.
# It is sourced by the ~/.bashrc file.
#
# Add your custom aliases and functions below
# ==============================================================================

# enable color support of ls/diff/dir/vdir and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  alias diff='diff --color=auto'
  alias dir='dir --color=auto'
  alias vdir='vdir --color=auto'

  alias grep='grep --color=auto'   # doesn't support regex
  alias fgrep='fgrep --color=auto' # supports extended regex
  alias egrep='egrep --color=auto' # doesn't support regex

  alias less='less -R'
fi

# some cd aliases
alias ..="cd .."
alias ...="cd ../.."

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
if command -v lsd >/dev/null 2>&1; then
  # only use lsd alias if it is installed
  alias ls='lsd --group-directories-first'
fi

if command -v batcat >/dev/null 2>&1; then
  # only use bat alias if batcat is installed
  alias bat='batcat'
fi

if command -v onefetch >/dev/null 2>&1; then
  # only use onefetch alias if onefatch is installed
  alias onefetch='onefetch --nerd-fonts'
fi

# ada compilation alias
alias adc="gnatmake -f -gnatwa -gnata -g"
function adc-e() {
  # compile and execute ada program
  adc "$1" && ./"${1%.*}"
}

# java compilation aliases
alias javaclean="find . -name *.class | xargs rm -f" # remove all .class files
alias javacall="javac *.java"                        # compile all .java files
function javac-e() {
  # compile and execute java program
  javac "$1" && java "${1%.*}"
}
function javatest-c() {
  # compile and run JUnit test
  javac "$1" && java org.junit.runner.JUnitCore "${1%.*}"
}

# eclipse alias
if [ -f ~/.eclipse/modeling-2023-09/eclipse/eclipse ]; then
  alias eclipse-idm="~/.eclipse/modeling-2023-09/eclipse/eclipse"
fi

# neo-vim alias
if command -v nvim > /dev/null 2>&1; then
  alias nv="nvim"
fi

# utility aliases
alias c="clear"
alias shut="shutdown now"
alias chut="shut"

function cheat() {
  curl -s cheat.sh/$1 | less
}

function print_bash_list() {
  echo "$1" | tr ':' '\n'
}
