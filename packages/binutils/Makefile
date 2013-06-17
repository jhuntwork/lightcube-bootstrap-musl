NM= binutils
#VRS= 2.23.2
VRS= 397a64b3
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
#URL-$(FILE)= http://ftp.gnu.org/gnu/$(NM)/$(FILE)
URL-$(FILE)= http://landley.net/aboriginal/mirror/$(FILE)
#SHA256-$(FILE)= fe914e56fed7a9ec2eb45274b1f2e14b0d8b4f41906a5194eac6883cfe5c1097
SHA256-$(FILE)= c7e0f0dfd2f53df76d2196b5bec0a2f0922c68c8719f9127efaf703c4f35939c

include $(MY_ROOT)/scripts/functions.mk

stage0: $(FILE)
	$(sep_dir_build)

compile-stage0:
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
	make install-gas install-ld install-binutils

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
	echo "MAKEINFO = :" >> Makefile
	make $(PM)
	make install-gas install-ld install-binutils
	make -C ld clean
	make -C ld LIB_PATH=/lib $(PM)
	cp -v ld/ld-new $(TT)/bin

stage2: $(FILE)
	$(sep_dir_build)

compile-stage2:
	$(musl_prep)
	cd ../$(DIR) ; rm -fv etc/standards.info
	cd ../$(DIR) ; sed -i '/^INFO/s/standards.info //' etc/Makefile.in
	LDFLAGS="-Wl,-static" \
	../$(DIR)/configure \
        --prefix=/ \
        --disable-shared \
        --disable-werror \
        --disable-nls \
        --disable-install-libbfd
	echo "MAKEINFO = :" >> Makefile
	make $(PM) tooldir=/
	make tooldir=/ install-gas install-ld install-binutils
