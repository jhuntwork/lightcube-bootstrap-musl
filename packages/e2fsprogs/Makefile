# e2fsprogs Makefile

NM= e2fsprogs
VRS= 1.42.2
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://prdownloads.sourceforge.net/$(NM)/$(FILE)
MD5-$(FILE)= 04f4561a54ad0419248316a00c016baa

include $(MY_ROOT)/scripts/functions.mk

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	$(musl_prep)
	sed -i -e 's@loff_t@off_t@g' \
	       -e 's@mincore.*@@' misc/e4defrag.c
	./configure \
          --prefix=/ \
	  --disable-libblkid \
	  --disable-libuuid \
	  --disable-uuidd \
	  --disable-fsck
	make V=1 $(PM)
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean compile-stage2
