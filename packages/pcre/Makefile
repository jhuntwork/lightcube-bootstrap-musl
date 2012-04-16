# PCRE Makefile

NM= pcre
VRS= 8.20
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/$(FILE)
MD5-$(FILE)= a1931c70e1273e3450d5036fe273d25c

PATCH= posix.patch

include $(MY_ROOT)/scripts/functions.mk

stage2: Makefile $(FILE) $(PATCH)
	$(std_build)

compile-stage2:
	patch -Np1 -i ../$(PATCH)
	$(musl_prep)
	./configure --prefix='' \
	--enable-utf8 \
	--enable-unicode-properties \
	--enable-pcregrep-libz \
	--disable-shared \
	--enable-static
	make $(PM)
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
