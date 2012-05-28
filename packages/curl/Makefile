# curl Makefile

NM= curl
VRS= 7.25.0
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://curl.haxx.se/download/$(FILE)
SHA256-$(FILE)= cfb29139dfeb2449bf8a89963c3aed7d87f034013f05564cc0330b435c90b491

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
