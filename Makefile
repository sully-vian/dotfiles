PREFIX = $(HOME)/.local
SRC = $(PREFIX)/src
CONFIG = $(HOME)/.config
SITES = $(SRC)/sites

YELLOW  := \033[33m
RESET := \033[0m
LOG := printf "$(YELLOW)[DOTFILES] %s$(RESET)\n"

SUCKLESS_TOOLS = st dmenu

.PHONY: stow $(SUCKLESS_TOOLS)

stow:
	stow .

$(SUCKLESS_TOOLS):
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

	@$(LOG) "cleaning $(SRC)/$@ before build"
	@git -C $(SRC)/$@ reset --hard HEAD --quiet
	@git -C $(SRC)/$@ clean -fd --quiet

