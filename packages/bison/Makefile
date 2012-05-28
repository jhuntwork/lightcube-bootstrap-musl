# Bison Makefile

NM= bison
VRS= 2.5
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://ftp.gnu.org/gnu/$(NM)/$(FILE)
SHA256-$(FILE)= 0a370df6ee2b23e9ec3043e1ab78878241aa008ec424926294dd4cb3475439b8

include $(MY_ROOT)/scripts/functions.mk

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	$(musl_prep)
	# Mods to allow gnulib readahead et al to work
	sed -i '/elif 0/s@0@defined SLOW_BUT_NO_HACKS@' lib/fseterr.c
	CC="gcc -DSLOW_BUT_NO_HACKS" \
	./configure --prefix='' 
	echo '#define YYENABLE_NLS 1' >> config.h
	make $(PM)
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean compile-stage2
