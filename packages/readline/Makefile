# readline Makefile

NM= readline
VRS= 6.2
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://ftp.gnu.org/gnu/$(NM)/$(FILE)
MD5-$(FILE)= 67948acb2ca081f23359d0256e9a271c

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
