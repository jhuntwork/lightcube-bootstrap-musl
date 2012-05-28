# e2fsprogs Makefile

NM= e2fsprogs
VRS= 1.42.2
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://prdownloads.sourceforge.net/$(NM)/$(FILE)
SHA256-$(FILE)= 420cf3d6e659665d1842d41d6d1a046bfe1f442dddf32dc7722f02a2bed9f470

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
