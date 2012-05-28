# M4 Makefile

NM= m4
VRS= 1.4.16
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.xz
URL-$(FILE)= http://ftp.gnu.org/gnu/$(NM)/$(FILE)
SHA256-$(FILE)= d5b5d51cf8f5b18f3bac39bc2f6b1e61f34d400136ae1a87d075e26a38028d5d

include $(MY_ROOT)/scripts/functions.mk

stage1: $(FILE)
	$(std_build)

compile-stage1:
	$(musl_prep)
	# Mods to allow gnulib readahead et al to work
	sed -i '/abort/d' lib/freadahead.c
	CC="gcc -DSLOW_BUT_NO_HACKS" \
	./configure --prefix=$(TT)
	make $(PM)
	make install

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	$(musl_prep)
	# Mods to allow gnulib readahead et al to work
	sed -i '/abort/d' lib/freadahead.c
	CC="gcc -DSLOW_BUT_NO_HACKS" \
	./configure --prefix='' --enable-threads
	make $(PM)
	make install

clean:
	-rm -rf $(DIR)

.PHONY: compile-stage1 clean compile-stage2
