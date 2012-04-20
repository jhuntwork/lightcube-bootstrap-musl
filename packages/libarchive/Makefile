# libarchive Makefile

NM= libarchive
VRS= 3.0.4
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://cloud.github.com/downloads/libarchive/libarchive/$(FILE)
MD5-$(FILE)= af443ca9a10ddbcbf00f7ae34ca7fc16

include $(MY_ROOT)/scripts/functions.mk

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	$(musl_prep)
	LDFLAGS='--static' \
	./configure --prefix='' \
	 --enable-static \
	 --disable-shared
	make $(PM)
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean compile-stage2
