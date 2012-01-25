# dash Makefile

NM= dash
VRS= 0.5.7
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://gondor.apana.org.au/~herbert/dash/files/$(FILE)
MD5-$(FILE)= f6cedb10ae7258adb5ab17a10ae80d51

# Targets

include $(MY_ROOT)/scripts/functions.mk

stage1: $(FILE)
	$(std_build)

compile-stage1:
	CC="gcc -D_GNU_SOURCE" ./configure --prefix=$(TT) \
	  --host=$(BUILD_TRUE) \
	  --build=$(BUILD_TRUE) \
	  --target=$(BUILD_TRUE) 
	make $(PM)
	make install
	ln -sf dash $(TT)/bin/sh

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	CC="gcc" ./configure --prefix=/usr --bindir=/bin
	make $(PM)
	make install
	ln -sf dash /bin/sh

clean:
	-rm -rf $(DIR)

.PHONY: compile-stage1 clean compile-stage2
