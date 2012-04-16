# Make Makefile

NM= make
VRS= 3.82
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
MD5-$(FILE)= 1a11100f3c63fcf5753818e59d63088f

include $(MY_ROOT)/scripts/functions.mk

stage1: $(FILE)
	$(std_build)

compile-stage1:
	sed -i 's/linux-gnu/linux-musl/g' `find . -name config.guess -o -name config.sub`
	CC="gcc -D__BEOS__ -D_GNU_SOURCE" \
	./configure --prefix=$(TT) \
	--disable-nls
	make $(PM)
	make install

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	sed -i 's/linux-gnu/linux-musl/g' `find . -name config.guess -o -name config.sub`
	CC="gcc -D__BEOS__" \
	./configure \
	--prefix='' \
	--disable-nls
	make $(PM)
	make install

clean:
	-rm -rf $(DIR)

.PHONY: compile-stage1 clean compile-stage2
