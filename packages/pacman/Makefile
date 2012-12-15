NM= pacman
VRS= HEAD
DIR= $(NM)-$(VRS)

include $(MY_ROOT)/scripts/functions.mk

stage2: Makefile
	$(basic_setup)
	git clone git://projects.archlinux.org/users/allan/pacman.git $(DIR)
	@$(call compile, $(DIR))
	@$(clean_build)
	@touch $@

compile-stage2:
	$(musl_prep)
	sed -i 's@usr/@@g' etc/makepkg.conf.in etc/pacman.conf.in
	sed -i "/MAN_DIRS/s@(.*)@({,local/}{,share/},opt/*}/{man,info})@" etc/makepkg.conf.in
	sed -i -e '/-O2 -pipe/s@^#@@' \
          -e '/-O2 -pipe/s@-O2 -pipe@$(CFLAGS)@' \
	  etc/makepkg.conf.in
	./autogen.sh
	./configure \
	 --prefix='' \
	 --disable-doc
	make V=1 $(PM)
	make install
