# ncurses Makefile

NM= ncurses
VRS= 5.9
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://ftp.gnu.org/gnu/$(NM)/$(FILE)
SHA256-$(FILE)= 9046298fb440324c9d4135ecea7879ffed8546dd1b58e59430ea07a4633f563b

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
