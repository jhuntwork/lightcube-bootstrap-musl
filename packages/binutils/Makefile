# Binutils Makefile

NM= binutils
VRS= 2.22
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://ftp.gnu.org/gnu/binutils/$(FILE)
MD5-$(FILE)= ee0f10756c84979622b992a4a61ea3f5

include $(MY_ROOT)/scripts/functions.mk

prebuild: $(FILE)
	$(sep_dir_build)

compile-prebuild:
	$(musl_prep)
	../$(DIR)/configure \
	--prefix=$(TT) \
	--host=$(BUILD_TRUE) \
	--build=$(BUILD_TRUE) \
	--target=$(BUILD_ARCH) \
	--with-sysroot=$(MY_BUILD) \
	--with-lib-path=$(TT)/lib \
	--disable-nls \
	--disable-shared \
	--disable-werror
	echo "MAKEINFO = :" >> Makefile
	make $(PM)
	make install

stage1: $(FILE)
	$(sep_dir_build)

compile-stage1:
	$(musl_prep)
	CC="$(BUILD_ARCH)-gcc -D_GNU_SOURCE" \
	AR=$(BUILD_ARCH)-ar \
	RANLIB=$(BUILD_ARCH)-ranlib \
	../$(DIR)/configure \
	--prefix=$(TT) \
	--disable-nls \
	--disable-werror \
	--disable-shared \
	--with-lib-path=$(TT)/lib
	make $(PM)
	make install
	make -C ld clean
	make -C ld LIB_PATH=/lib $(PM)
	cp -v ld/ld-new $(TT)/bin

stage2: $(FILE)
	$(sep_dir_build)

compile-stage2:
	$(musl_prep)
	cd ../$(DIR) ; rm -fv etc/standards.info
	cd ../$(DIR) ; sed -i '/^INFO/s/standards.info //' etc/Makefile.in
	CC="gcc -static" \
	../$(DIR)/configure \
	--prefix='' \
	--disable-werror \
	--disable-nls \
	--disable-shared \
	--libdir=/lib
	make $(PM)
	make install
	cp ../$(DIR)/include/libiberty.h /include

clean:
	-rm -rf $(DIR)
	-rm -rf $(NM)-build

.PHONY: compile-prebuild clean compile-stage1 compile-stage2
