# Bison Makefile

NM= bison
VRS= 2.5
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://ftp.gnu.org/gnu/$(NM)/$(FILE)
MD5-$(FILE)= 9dba20116b13fc61a0846b0058fbe004

# Targets

include $(MY_ROOT)/scripts/functions.mk

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	sed -i 's@linux-gnu@linux-musl@g' build-aux/config.sub
	sed -i '/elif 0/s@0@defined SLOW_BUT_NO_HACKS@' lib/fseterr.c
	hush -c 'CC="gcc -DSLOW_BUT_NO_HACKS" \
	./configure --prefix=/usr --libdir=/usr/$(MY_LIBDIR) \
	--host=$(BUILD_TRUE) \
	--build=$(BUILD_TRUE) \
	--target=$(BUILD_TRUE)'
	echo '#define YYENABLE_NLS 1' >> config.h
	hush -c 'make $(PM)'
	hush -c 'make install'

clean:
	-rm -rf $(DIR)

.PHONY: clean compile-stage2
