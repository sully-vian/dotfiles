#!/usr/bin/env bash

# XDG variables
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"

export PATH="$HOME/.local/bin/:$PATH"

# JAVA
JAVA_HOME="/usr/lib/jvm/default"
export PATH="$JAVA_HOME/bin:$PATH"

# PHP with Composer
[ -d "$HOME/.config/composer/vendor/bin" ] && export PATH="$HOME/.config/composer/vendor/bin:$PATH"

# PHP Symfony
[ -d "$HOME/.config/symfony-cli/bin" ] && export PATH="$HOME/.config/symfony-cli/bin:$PATH"

# Alire
[ -d "$HOME/.alire/bin/" ] && export PATH="$HOME/.alire/bin/:$PATH"

# NPM
export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

# Bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# texlive path
export PATH="/usr/local/texlive/2024/bin/x86_64-linux:$PATH"
export INFOPATH="/usr/local/texlive/2024/texmf-dist/doc/info:$INFOPATH"

alias startx="startx -- -configdir $HOME/.config/xorg" 

# Do not run bashrc if display is not set
if [ -f "$HOME/.bashrc" ] && [ -n "$DISPLAY" ]; then
    . "$HOME/.bashrc"
fi

