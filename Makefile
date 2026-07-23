PREFIX = $(HOME)/.local
SRC = $(PREFIX)/src
CONFIG = $(HOME)/.config
SITES = $(SRC)/sites

CYAN  := \033[36m
RESET := \033[0m
LOG := printf "$(CYAN)[DOTFILES] %s$(RESET)\n"


.PHONY: help stow st dmenu

.DEFAULT_GOAL := help

help: ## Show this help message
	@rg '^([ a-zA-Z_-]+): ## (.*)$$' -r $$'$(CYAN)$$1$(RESET)--$$2' $(MAKEFILE_LIST) | column -t -s $$'--'

stow: ## Generate symlinks
	stow .

check:
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

foo:
	echo $(SHELL)
