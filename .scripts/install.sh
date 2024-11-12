#!/bin/bash

# Define the dotfiles directory
DOTFILES_DIR="$HOME/dotfiles"

# List of dotfiles to be symlinked
DOTFILES=(
    ".config/bat/config"
    ".scripts"
    ".var/app/com.raggesilver.BlackBox/config/glib-2.0/settings/keyfile"
    ".bashrc"
    ".inputrc"
    ".tmux.conf"
    ".vimrc"
)

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}Dotfiles directory: $DOTFILES_DIR${NC}"
echo -e "${BLUE}Installing dotfiles...${NC}"
echo

# Create symlinks
for file in "${DOTFILES[@]}"; do
    echo -e "${BLUE}[Processing $file]${NC}"
    target="$HOME/$file"
    target_dir=$(dirname "$target")

    # Create the target directory if it does not exist
    if [ ! -d "$target_dir" ]; then
        echo -e "${YELLOW}Missing directory $target_dir${NC}"
        echo -e "${YELLOW}Creating directory $target_dir${NC}"
        mkdir -p "$target_dir"
    fi

    # Backup existing files
    if [ -e "$target" ]; then
        echo -e "${YELLOW}Backing up existing $target to $target.bak${NC}"
        mv "$target" "$target.bak"
    fi

    # Create the symlink
    echo -e "${GREEN}Creating symlink for $file${NC}"
    ln -s "$DOTFILES_DIR/$file" "$target"
    echo
done

# Source the new .bashrc and rebind the inputrc
if [ -f "$HOME/.bashrc" ]; then
    echo -e "${BLUE}Sourcing .bashrc${NC}"
    source "$HOME/.bashrc"
fi

# Rebind the inputrc
if [ -f "$HOME/.inputrc" ]; then
    echo -e "${BLUE}Rebinding .inputrc${NC}"
    bind -f "$HOME/.inputrc"
fi

echo -e "${GREEN}Dotfiles installation complete!${NC}"
