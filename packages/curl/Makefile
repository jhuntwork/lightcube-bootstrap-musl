# curl Makefile

NM= curl
VRS= 7.28.0
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://curl.haxx.se/download/$(FILE)
SHA256-$(FILE)= b7f510db60f520ba0bc8a39cccee7e913362205b4a7709e16af2cba14093099b

include $(MY_ROOT)/scripts/functions.mk

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	$(musl_prep)
	./configure \
	  --prefix=/ \
	  --with-ssl \
	  --with-ca-bundle=/etc/ssl/certs/ca-bundle.crt
	make $(PM)
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean compile-stage2
