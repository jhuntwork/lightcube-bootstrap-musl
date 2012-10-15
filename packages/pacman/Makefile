# pacman Makefile

NM= pacman
VRS= 4.0.3
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= ftp://ftp.archlinux.org/other/pacman/$(FILE)
SHA256-$(FILE)= a48696ae51aaccf31a69ea7916ba9b06e7836eb933b8a281c666729c9d55ce25

include $(MY_ROOT)/scripts/functions.mk

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	$(musl_prep)
	sed -i 's@usr/@@g' etc/makepkg.conf.in etc/pacman.conf.in
	sed -i "/MAN_DIRS/s@(.*)@({,local/}{,share/},opt/*}/{man,info})@" etc/makepkg.conf.in
	sed -i -e '/-O2 -pipe/s@^#@@' \
          -e '/-O2 -pipe/s@-O2 -pipe@$(CFLAGS)@' \
	  etc/makepkg.conf.in
	./configure \
	 --prefix='' \
	 --with-libcurl \
	 --disable-doc
	make V=1 $(PM)
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean compile-stage2
