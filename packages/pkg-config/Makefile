# pkg-config Makefile

NM= pkg-config
VRS= 0.25
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://pkgconfig.freedesktop.org/releases/$(FILE)
MD5-$(FILE)= a3270bab3f4b69b7dc6dbdacbcae9745

include $(MY_ROOT)/scripts/functions.mk

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	$(musl_prep)
	./configure \
          --prefix='' \
	  --with-pc-path=/lib/pkgconfig
	make $(PM)
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean compile-stage2
