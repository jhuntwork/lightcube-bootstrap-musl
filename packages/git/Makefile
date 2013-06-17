NM= git
VRS= 1.8.0.2
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://git-core.googlecode.com/files/$(FILE)
SHA256-$(FILE)= c06d5d29389e90583d16ec41d5be931593196f6842f9b14e910a0b5781c10e07

include $(MY_ROOT)/scripts/functions.mk

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	sed -i 's@/usr/bin/perl@/bin/perl@g' `grep -lr "/usr/bin/perl" .`
	sed -i '/absolute directory/d' configure
	./configure \
	 --prefix='' \
	 --libexecdir=/lib/git-core \
	 --without-tcltk \
	 --without-python \
	 --with-curl
	make NO_MSGFMT=1 NO_GETTEXT=1 V=1 $(PM)
	make NO_MSGFMT=1 NO_GETTEXT=1 install
