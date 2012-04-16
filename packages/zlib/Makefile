# Zlib Makefile

NM= zlib
VRS= 1.2.6
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://zlib.net/$(FILE)
MD5-$(FILE)= dc2cfa0d2313ca77224b4d932b2911e9

include $(MY_ROOT)/scripts/functions.mk

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	# Busybox doesn't support mktemp -u
	sed -i 's@mktemp -u@mktemp@' Makefile.in
	./configure --prefix='' --static
	make
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean compile-stage2
