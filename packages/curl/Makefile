# curl Makefile

NM= curl
VRS= 7.25.0
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://curl.haxx.se/download/$(FILE)
MD5-$(FILE)= f0303d47d9d3e6e4f08c2863c6504823

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
