#!/bin/bash

# Define the dotfiles directory
DOTFILES_DIR="$FAKE_HOME/dotfiles"

# List of dotfiles to be symlinked
DOTFILES=(
    ".config/bat/config"
    ".scripts/"
    ".var/app/com.raggesilver.BlackBox/config/glib-2.0/settings/keyfile"
    ".bashrc"
    ".inputrc"
    ".tmux.conf"
    ".vimrc"
)

# Create symlinks
for file in "${DOTFILES[@]}"; do
    target="$FAKE_HOME/$file"
    if [ -e "$target" ]; then
        echo "Backing up existing $target to $target.bak"
        mv "$target" "$target.bak"
    fi
    echo "Creating symlink for $file"
    ln -s "$DOTFILES_DIR/$file" "$target"
done

# Source the new .bashrc and rebind the inputrc
if [ -f "$FAKE_HOME/.bashrc" ]; then
    echo "Sourcing .bashrc"
    source "$FAKE_HOME/.bashrc"
fi

# Rebind the inputrc
if [ -f "$FAKE_HOME/.inputrc" ]; then
    echo "Rebinding .inputrc"
    source "$FAKE_HOME/.inputrc"
fi

echo "Dotfiles installation complete!"
