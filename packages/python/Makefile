# python Makefile

NM= Python
VRS= 3.2.3
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://python.org/ftp/python/$(VRS)/$(FILE)
SHA256-$(FILE)= 5648ec81f93870fde2f0aa4ed45c8718692b15ce6fd9ed309bfb827ae12010aa

include $(MY_ROOT)/scripts/functions.mk

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	$(musl_prep)
	./configure --prefix=/ \
	  --enable-shared
	make $(PM)
	make install
	ln -sf python3 /bin/python

clean:
	-rm -rf $(DIR)

.PHONY: clean compile-stage2
