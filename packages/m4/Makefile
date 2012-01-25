# M4 Makefile

NM= m4
VRS= 1.4.16
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
MD5-$(FILE)= 8a7cef47fecab6272eb86a6be6363b2f

# Targets

include $(MY_ROOT)/scripts/functions.mk

stage1: $(FILE)
	$(std_build)

compile-stage1:
	sed -i 's@linux-gnu@linux-musl@g' build-aux/config.sub
	# Mods to allow gnulib readahead et al to work
	sed -i '/abort/d' lib/freadahead.c
	CC="gcc -DSLOW_BUT_NO_HACKS" \
	./configure --prefix=$(TT) \
	--host=$(BUILD_TRUE) \
	--build=$(BUILD_TRUE) \
	--target=$(BUILD_TRUE)
	make $(PM)
	make install

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	sed -i 's@linux-gnu@linux-musl@g' build-aux/config.sub
	# Mods to allow gnulib readahead et al to work
	sed -i '/abort/d' lib/freadahead.c
	hush -c 'CC="gcc -DSLOW_BUT_NO_HACKS" \
	./configure --prefix=/usr --enable-threads \
	--host=$(BUILD_TRUE) \
	--build=$(BUILD_TRUE) \
	--target=$(BUILD_TRUE)'
	hush -c 'make $(PM)'
	hush -c 'make install'

clean:
	-rm -rf $(DIR)

.PHONY: compile-stage1 clean compile-stage2
