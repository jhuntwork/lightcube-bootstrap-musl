# python Makefile

NM= Python
VRS= 3.2.3
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://python.org/ftp/python/$(VRS)/$(FILE)
MD5-$(FILE)= cea34079aeb2e21e7b60ee82a0ac286b

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
