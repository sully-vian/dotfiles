PREFIX = $(HOME)/.local
SRC = $(PREFIX)/src
CONFIG = $(HOME)/.config
SITES = $(SRC)/sites

CYAN  := \033[36m
RESET := \033[0m
LOG := printf "$(CYAN)[DOTFILES] %s$(RESET)\n"

COMPLETIONS_DIR=$(PREFIX)/share/bash-completion/completions

FONT_DIR=$(PREFIX)/share/fonts
FONT_NAME=FiraCode

.PHONY: help stow update check shellcheck luacheck fonts st dmenu

.DEFAULT_GOAL := help

help: ## Show this help message
	@rg '^([ a-zA-Z_-]+): ## (.*)$$' -r $$'$(CYAN)$$1$(RESET)\t$$2' $(MAKEFILE_LIST) | column -t -s $$'\t'

stow: ## Generate symlinks
	stow .

update: ## Update nvim packages and suckless submodules
	bun update
	nvim --headless -c 'lua vim.pack.update(nil, { force = true })' -c 'qa'; echo
	git submodule update --remote --recursive

check: luacheck shellcheck ## Statically check code

shellcheck: ## Statically check shell scripts
	@$(LOG) "Checking shell scripts"
	fd -H -t f -E .git -E .local/src -x file | grep -i "shell script" | cut -d: -f1 | xargs shellcheck -x

luacheck: ## Statically check Lua files
	@$(LOG) "Checking Neovim Lua files"
	lua-language-server --check $(CONFIG)/nvim

completions: ## Download and install bash-completion scripts
	@$(LOG) "Installing bun completion"
	bun completions > $(COMPLETIONS_DIR)/bun
	@$(LOG) "Installing Symfony CLI completion"
	symfony completion > $(COMPLETIONS_DIR)/symfony

fonts: ## Download and install the latest Fira Code Nerd Font
	@$(LOG) "Downloading $(FONT_NAME) archive..."
	curl -fLo /tmp/$(FONT_NAME).tar.xz https://github.com/ryanoasis/nerd-fonts/releases/latest/download/$(FONT_NAME).tar.xz
	@$(LOG) "Extracting TTF files..."
	tar -xf /tmp/$(FONT_NAME).tar.xz -C $(FONT_DIR) --wildcards "*.ttf"
	@$(LOG) "Updating font cache..."
	fc-cache -fv

st dmenu: ## Build st and dmenu
	@$(LOG) "cleaning $(SRC)/$@ before build"
	@git -C $(SRC)/$@ reset --hard HEAD --quiet
	@git -C $(SRC)/$@ clean -fd --quiet

	@for patch in $$(cat $(CONFIG)/$@/patches); do \
		patch_file=$$(cd $(SITES) && git log -1 --format="" --name-only tools.suckless.org/$@/patches/$$patch/*.diff); \
		$(LOG) "Applying $$patch patch: $$patch_file"; \
		patch -d $(SRC)/$@ -p1 < $(SITES)/$$patch_file; \
	done;
	cp $(CONFIG)/$@/config.h $(SRC)/$@/config.def.h
	$(MAKE) -C $(SRC)/$@ clean install PREFIX=$(PREFIX)
	$(MAKE) -C $(SRC)/$@ clean

	@$(LOG) "cleaning $(SRC)/$@ after build"
	@git -C $(SRC)/$@ reset --hard HEAD --quiet
	@git -C $(SRC)/$@ clean -fd --quiet

