# readline Makefile

NM= readline
VRS= 6.2
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://ftp.gnu.org/gnu/$(NM)/$(FILE)
SHA256-$(FILE)= 79a696070a058c233c72dd6ac697021cc64abd5ed51e59db867d66d196a89381

include $(MY_ROOT)/scripts/functions.mk

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	$(musl_prep)
	sed -i '/MV.*old/d' Makefile.in
	sed -i '/{OLDSUFF}/c:' support/shlib-install
	./configure \
          --prefix=''
	make $(PM) SHLIB_LIBS=-lncurses
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean compile-stage2
