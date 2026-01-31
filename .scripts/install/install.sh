#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

DOTFILES_DIR="$HOME/dotfiles"

echo -e "${BLUE}Dotfiles directory: $DOTFILES_DIR${NC}"
echo -e "${BLUE}Installing dotfiles...${NC}"

if ! command -v stow >/dev/null 2>&1; then
    echo -e "${YELLOW}You don't have gnu-stow installed.${NC}"
    echo -e "${YELLOW}Install it at https://www.gnu.org/software/stow/${NC}"
    exit 1
fi

echo "You have gnu-stow installed, stowing dotfile folder..."
stow -d "$DOTFILES_DIR" -t "$HOME" .
echo -e "${BLUE}Done.${NC}"
exit 0

