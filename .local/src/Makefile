PREFIX = $(HOME)/.local
SRC = $(PREFIX)/src
CONFIG = $(HOME)/.config

PROGRAMS = st dmenu

.PHONY: all $(PROGRAMS)

all: $(PROGRAMS)

$(PROGRAMS):
	cp $(CONFIG)/$@.h $(SRC)/$@/config.h
	$(MAKE) -C $(SRC)/$@ clean install PREFIX=$(PREFIX)
	$(MAKE) -C $(SRC)/$@ clean
	rm $(SRC)/$@/config.h
