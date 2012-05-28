# pacman Makefile

NM= pacman
VRS= 9a76a458b898ea462666491cb74cd95372462da4
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://projects.archlinux.org/pacman.git/snapshot/$(FILE)
MD5-$(FILE)= 15ea343a147e288af0318a6eb812bcd2

PATCH1= pacman-makepkg_portability.patch
PATCH2= pacman-purge_targets_fix.patch

include $(MY_ROOT)/scripts/functions.mk

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	$(musl_prep)
	patch -Np1 -i ../$(PATCH1)
	patch -Np1 -i ../$(PATCH2)
	sed -i 's@usr/@@g' etc/makepkg.conf.in etc/pacman.conf.in
	sed -i "/MAN_DIRS/s@(.*)@({,local/}{,share/},opt/*}/{man,info})@" etc/makepkg.conf.in
	sed -i -e '/-O2 -pipe/s@^#@@' \
          -e '/-O2 -pipe/s@-O2 -pipe@-D_GNU_SOURCE -O2 -pipe -fomit-frame-pointer -fno-asynchronous-unwind-tables@' \
	  etc/makepkg.conf.in
	./autogen.sh
	./configure \
	 --prefix='' \
	 --disable-doc
	make V=1 $(PM)
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean compile-stage2
