# pacman Makefile

NM= pacman
VRS= 9a76a458b898ea462666491cb74cd95372462da4
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://projects.archlinux.org/pacman.git/snapshot/$(FILE)
SHA256-$(FILE)= 08077ab4f63957a80f3de7229868d9ced07fe6ab8d551f83315f09749b415a94

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
          -e '/-O2 -pipe/s@-O2 -pipe@$(CFLAGS)@' \
	  etc/makepkg.conf.in
	./autogen.sh
	./configure \
	 --prefix='' \
	 --with-libcurl \
	 --disable-doc
	make V=1 $(PM)
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean compile-stage2
