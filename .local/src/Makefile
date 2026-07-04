PREFIX = $(HOME)/.local
ST_REPO = $(PREFIX)/src/st
ST_CONFIG = $(HOME)/.config/st.h

.PHONY: st

st:
	cp $(ST_CONFIG) $(ST_REPO)/config.h
	$(MAKE) -C $(ST_REPO) clean install PREFIX=$(PREFIX)
