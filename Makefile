PREFIX = $(HOME)/.local
SRC = $(PREFIX)/src
CONFIG = $(HOME)/.config
SITES = $(SRC)/sites

CYAN  := \033[36m
RESET := \033[0m
LOG := printf "$(CYAN)[DOTFILES] %s$(RESET)\n"


.PHONY: help stow update check st dmenu

.DEFAULT_GOAL := help

help: ## Show this help message
	@rg '^([ a-zA-Z_-]+): ## (.*)$$' -r $$'$(CYAN)$$1$(RESET)\t$$2' $(MAKEFILE_LIST) | column -t -s $$'\t'

stow: ## Generate symlinks
	stow .

update: ## Update nvim packages and suckless submodules
	nvim --headless -c 'lua vim.pack.update(nil, { force = true })' -c 'qa'; echo
	git submodule update --remote --recursive

check: ## Statically check code
	lua-language-server --check $(CONFIG)/nvim

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

