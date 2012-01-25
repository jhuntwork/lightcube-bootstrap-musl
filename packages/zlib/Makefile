# Zlib Makefile

NM= zlib
VRS= 1.2.5
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://zlib.net/$(FILE)
MD5-$(FILE)= be1e89810e66150f5b0327984d8625a0

# Targets

include $(MY_ROOT)/scripts/functions.mk

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	./configure --prefix=/usr --libdir=/usr/$(MY_LIBDIR)
	make
	make install
	mv /usr/$(MY_LIBDIR)/libz.so.* /$(MY_LIBDIR)/
	ln -sf ../../$(MY_LIBDIR)/libz.so.1.2.5 /usr/$(MY_LIBDIR)/libz.so

clean:
	-rm -rf $(DIR)

.PHONY: clean compile-stage2
