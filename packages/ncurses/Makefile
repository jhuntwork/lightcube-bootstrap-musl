# ncurses Makefile

NM= ncurses
VRS= 5.9
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://ftp.gnu.org/gnu/$(NM)/$(FILE)
MD5-$(FILE)= 8cb9c412e5f2d96bc6f459aa8c6282a1

FILE1= ncurses-fallback.c

include $(MY_ROOT)/scripts/functions.mk

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	$(musl_prep)
	cp ../$(FILE1) ncurses/fallback.c
	./configure \
          --prefix='' \
          --with-fallbacks="linux vt100 xterm xterm256-color" \
          --with-shared \
          --disable-debug \
          --disable-nls \
          --includedir=/include \
          --mandir=/share/man
	make $(PM)
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean compile-stage2
