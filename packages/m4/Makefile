# M4 Makefile

NM= m4
VRS= 1.4.16
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
MD5-$(FILE)= 8a7cef47fecab6272eb86a6be6363b2f

include $(MY_ROOT)/scripts/functions.mk

stage1: $(FILE)
	$(std_build)

compile-stage1:
	sed -i 's/linux-gnu/linux-musl/g' `find . -name config.guess -o -name config.sub`
	# Mods to allow gnulib readahead et al to work
	sed -i '/abort/d' lib/freadahead.c
	CC="gcc -DSLOW_BUT_NO_HACKS" \
	./configure --prefix=$(TT)
	make $(PM)
	make install

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	sed -i 's/linux-gnu/linux-musl/g' `find . -name config.guess -o -name config.sub`
	# Mods to allow gnulib readahead et al to work
	sed -i '/abort/d' lib/freadahead.c
	CC="gcc -DSLOW_BUT_NO_HACKS" \
	./configure --prefix='' --enable-threads
	make $(PM)
	make install

clean:
	-rm -rf $(DIR)

.PHONY: compile-stage1 clean compile-stage2
