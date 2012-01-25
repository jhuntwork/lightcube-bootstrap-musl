# Binutils Makefile

NM= binutils
VRS= 2.21.1
DIR= $(NM)-$(VRS)

FILE= $(DIR)a.tar.bz2
URL-$(FILE)= http://ftp.gnu.org/gnu/binutils/$(FILE)
MD5-$(FILE)= bde820eac53fa3a8d8696667418557ad

PATCH1= binutils-pid_t.patch

# Targets

include $(MY_ROOT)/scripts/functions.mk

prebuild: $(FILE)
	$(sep_dir_build)

compile-prebuild:
	sed -i 's@linux-gnu@linux-musl@g' ../$(DIR)/config.sub
	../$(DIR)/configure \
	--prefix=$(TT) \
	--host=$(BUILD_TRUE) \
	--build=$(BUILD_TRUE) \
	--target=$(BUILD_ARCH) \
	--with-sysroot=$(MY_BUILD) \
	--with-lib-path=$(TT)/lib \
	--disable-nls \
	--disable-werror
	echo "MAKEINFO = :" >> Makefile
	make $(PM)
	make install

stage1: $(FILE)
	$(sep_dir_build)

compile-stage1:
	sed -i 's@linux-gnu@linux-musl@g' ../$(DIR)/config.sub
	cd ../$(DIR) ; patch -Np1 -i ../$(PATCH1)
	CC="$(BUILD_ARCH)-gcc -D_GNU_SOURCE" \
	AR=$(BUILD_ARCH)-ar \
	RANLIB=$(BUILD_ARCH)-ranlib \
	../$(DIR)/configure \
	--prefix=$(TT) \
	--host=$(BUILD_TRUE) \
	--build=$(BUILD_TRUE) \
	--target=$(BUILD_TRUE) \
	--disable-nls \
	--disable-werror \
	--with-lib-path=$(TT)/lib
	make $(PM)
	make install
	make -C ld clean
	make -C ld LIB_PATH=/usr/lib:/lib $(PM)
	cp -v ld/ld-new $(TT)/bin

stage2: $(FILE)
	$(sep_dir_build)

compile-stage2:
	sed -i 's@linux-gnu@linux-musl@g' ../$(DIR)/config.sub
	cd ../$(DIR) ; patch -Np1 -i ../$(PATCH1)
	cd ../$(DIR) ; rm -fv etc/standards.info
	cd ../$(DIR) ; sed -i '/^INFO/s/standards.info //' etc/Makefile.in
	hush -c 'CC="gcc -D_GNU_SOURCE" ../$(DIR)/configure \
	--prefix=/usr \
	--disable-werror \
	--host=$(BUILD_TRUE) \
	--build=$(BUILD_TRUE) \
	--target=$(BUILD_TRUE) \
	--disable-nls \
	--enable-shared \
	--libdir=/usr/lib'
	hush -c 'make tooldir=/usr $(PM)'
	hush -c 'make tooldir=/usr install'
	cp ../$(DIR)/include/libiberty.h /usr/include

clean:
	-rm -rf $(DIR)
	-rm -rf $(NM)-build

.PHONY: compile-prebuild clean compile-stage1 compile-stage2
