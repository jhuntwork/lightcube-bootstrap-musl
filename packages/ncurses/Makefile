# Ncurses Makefile

NM= ncurses
VRS= 5.9
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
MD5-$(FILE)= 8cb9c412e5f2d96bc6f459aa8c6282a1

# Targets

include $(MY_ROOT)/scripts/functions.mk

stage1: $(FILE)
	$(std_build)

compile-stage1:
	sed -i 's@linux-gnu@linux-musl@g' config.sub
	CC="gcc -D_GNU_SOURCE" ./configure --prefix=$(TT) --with-shared \
	 --without-debug --without-ada --enable-overwrite \
	 --without-cxx-binding \
	 --libdir=$(TT)/$(MY_LIBDIR) \
	 --host=$(BUILD_TRUE) \
	 --build=$(BUILD_TRUE) \
	 --target=$(BUILD_TRUE) 
	make $(PM)
	make install

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	sed -i 's@linux-gnu@linux-musl@g' `find . -name config.sub -o -name config.guess`
	hush -c './configure \
	 --prefix=/usr \
	 --with-shared \
	 --without-debug \
         --without-dlsym \
         --without-cxx-binding'
	hush -c 'make'
	hush -c 'make install'

clean:
	-rm -rf $(DIR)

.PHONY: compile-stage1 clean compile-stage2
