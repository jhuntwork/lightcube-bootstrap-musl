# python Makefile

NM= Python
VRS= 2.7.4
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://python.org/ftp/python/$(VRS)/$(FILE)
SHA256-$(FILE)= 035f705d40f8ec966f43206ba5008708e911cbfa99ab3b984af1222e24e9a359

include $(MY_ROOT)/scripts/functions.mk

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	$(musl_prep)
	./configure --prefix=/ \
	  --enable-shared
	make $(PM)
	make install
	ln -sf python2 /bin/python
