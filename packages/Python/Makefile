# Python Makefile

NM= Python
VRS= 2.7.2
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://www.python.org/ftp/python/$(VRS)/$(FILE)
MD5-$(FILE)= ba7b2f11ffdbf195ee0d111b9455a5bd

# Targets

include $(MY_ROOT)/scripts/functions.mk

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	sed -i 's@linux-gnu@linux-musl@g' Modules/_ctypes/libffi/config.sub
	hush -c 'CC="gcc" ./configure --prefix=/usr --enable-shared'
	hush -c 'make $(PM)'
	hush -c 'make install'

clean:
	-rm -rf $(DIR)

.PHONY: clean compile-stage2
