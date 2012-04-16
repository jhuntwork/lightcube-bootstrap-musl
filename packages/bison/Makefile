# Bison Makefile

NM= bison
VRS= 2.5
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://ftp.gnu.org/gnu/$(NM)/$(FILE)
MD5-$(FILE)= 9dba20116b13fc61a0846b0058fbe004

include $(MY_ROOT)/scripts/functions.mk

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	sed -i 's/linux-gnu/linux-musl/g' `find . -name config.guess -o -name config.sub`
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
