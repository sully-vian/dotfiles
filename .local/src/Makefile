PREFIX = $(HOME)/.local
SRC = $(PREFIX)/src
CONFIG = $(HOME)/.config
SITES = $(SRC)/sites

PROGRAMS = st dmenu

.PHONY: all $(PROGRAMS)

all: $(PROGRAMS)

$(PROGRAMS):
	@echo " -> cleaning $(SRC)/$@ before build"
	@git -C $(SRC)/$@ reset --hard HEAD --quiet
	@git -C $(SRC)/$@ clean -fd --quiet

	@for patch in $$(cat $(CONFIG)/$@/patches); do \
		patch_file=$$(cd $(SITES) && git log -1 --format="" --name-only tools.suckless.org/$@/patches/$$patch/*.diff); \
		echo " -> Applying $$patch: $$patch_file"; \
		patch -d $(SRC)/$@ -p1 < $(SITES)/$$patch_file; \
	done;

	cp $(CONFIG)/$@/config.h $(SRC)/$@/config.def.h

	$(MAKE) -C $(SRC)/$@ clean install PREFIX=$(PREFIX)
	$(MAKE) -C $(SRC)/$@ clean
