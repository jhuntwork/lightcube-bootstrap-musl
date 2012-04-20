# pacman Makefile

NM= pacman
VRS= 4.0.3
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= ftp://ftp.archlinux.org/other/pacman/$(FILE)
MD5-$(FILE)= 387965c7125e60e5f0b9ff3b427fe0f9

include $(MY_ROOT)/scripts/functions.mk

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	$(musl_prep)
	LDFLAGS='--static' \
	./configure --prefix='' \
	 --enable-static \
	 --disable-shared
	make $(PM)
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean compile-stage2
