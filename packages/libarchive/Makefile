# libarchive Makefile

NM= libarchive
VRS= 3.0.4
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://www.libarchive.org/downloads/$(FILE)
SHA256-$(FILE)= 76e8d7c7b100ec4071e48c1b7d3f3ea1d22b39db3e45b7189f75b5ff4df90fac

include $(MY_ROOT)/scripts/functions.mk

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	$(musl_prep)
	./configure --prefix=/
	make $(PM)
	make install
