# Gcc Makefile

NM= gcc
VRS= 4.5.3
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://ftp.gnu.org/gnu/gcc/$(DIR)/$(FILE)
#MD5-$(FILE)= 028115c4fbfb6cfd75d6369f4a90d87e
MD5-$(FILE)= 8e0b5c12212e185f3e4383106bfa9cc6
#MD5-$(FILE)= d79f553e7916ea21c556329eacfeaa16

FILE1= mpfr-3.0.1.tar.bz2
URL-$(FILE1)= $(HTTP)/mpfr/$(FILE1)
MD5-$(FILE1)= bfbecb2eacb6d48432ead5cfc3f7390a

FILE2= gmp-5.0.2.tar.bz2
URL-$(FILE2)= $(HTTP)/gmp/$(FILE2)
MD5-$(FILE2)= 0bbaedc82fb30315b06b1588b9077cd3

FILE3= mpc-0.9.tar.gz
URL-$(FILE3)= $(HTTP)/mpc/$(FILE3)
MD5-$(FILE3)= 0d6acab8d214bd7d1fbbc593e83dd00d

# Targets

include $(MY_ROOT)/scripts/functions.mk

prebuild: $(FILE) $(FILE1) $(FILE2) $(FILE3)
	$(sep_dir_build)

compile-prebuild:
	cd ../$(DIR) ; mv -v $$(unpack ../$(FILE1) silent) mpfr
	cd ../$(DIR) ; mv -v $$(unpack ../$(FILE2) silent) gmp
	cd ../$(DIR) ; mv -v $$(unpack ../$(FILE3) silent) mpc
	sed -i 's@linux-gnu@linux-musl@g' ../$(DIR)/config.sub ../$(DIR)/gmp/configfsf.sub ../$(DIR)/mpfr/config.sub ../$(DIR)/mpc/config.sub
	cd ../$(DIR) ; for file in $$(find gcc/config/i386 -name linux64.h -o -name linux.h) ; do \
    sed -i -e 's@/lib\(64\)\?\(32\)\?/ld@$(TT)&@g' \
	-e 's@lib/ld-linux.so.2@lib/ld-musl-i386.so.1@' \
	-e 's@lib64/ld-linux-x86-64.so.2@lib/ld-musl-x86_64.so.1@' \
	-e 's@/usr@$(TT)@g' $$file && \
	echo '' >> $$file && \
	echo '#undef STANDARD_STARTFILE_PREFIX_1' >> $$file && \
	echo '#undef STANDARD_STARTFILE_PREFIX_2' >> $$file && \
	echo '#define STANDARD_STARTFILE_PREFIX_1 "$(TT)/lib/"' >> $$file && \
	echo '#define STANDARD_STARTFILE_PREFIX_2 ""' >> $$file && \
	touch $$file.orig ; \
	done
	cd ../$(DIR) ; sed -i '/MULTILIB_OSDIRNAMES/d' `find gcc/config -name t-linux64`
	cd ../$(DIR) ; sed -i '/^CROSS_SYSTEM_HEADER_DIR/s@= .*@= $(TT)/include@' gcc/Makefile.in
	cd ../$(DIR) ; sed -i '/#define STANDARD_INCLUDE_DIR/s@"/usr/include"@0@g' gcc/cppdefault.c
	../$(DIR)/configure \
	--prefix=$(TT) \
	--host=$(BUILD_TRUE) \
	--build=$(BUILD_TRUE) \
	--target=$(BUILD_ARCH) \
	--with-sysroot=$(MY_BUILD) \
	--with-newlib \
	--without-headers \
	--with-local-prefix=$(TT) \
	--disable-nls \
	--disable-shared \
	--disable-decimal-float \
	--disable-threads \
	--disable-libmudflap \
	--disable-libssp \
	--disable-libgomp \
	--disable-multilib \
	--enable-languages=c
	make $(PM)
	make install

stage1: $(FILE) $(FILE1) $(FILE2) $(FILE3)
	$(sep_dir_build)

compile-stage1:
	cd ../$(DIR) ; mv -v $$(unpack ../$(FILE1) silent) mpfr
	cd ../$(DIR) ; mv -v $$(unpack ../$(FILE2) silent) gmp
	cd ../$(DIR) ; mv -v $$(unpack ../$(FILE3) silent) mpc
	sed -i 's@linux-gnu@linux-musl@g' ../$(DIR)/config.sub ../$(DIR)/gmp/configfsf.sub ../$(DIR)/mpfr/config.sub ../$(DIR)/mpc/config.sub
	cd ../$(DIR) ; for file in $$(find gcc/config/i386 -name linux64.h -o -name linux.h) ; do \
	sed -i -e 's@/lib\(64\)\?\(32\)\?/ld@$(TT)&@g' \
	-e 's@lib/ld-linux.so.2@lib/ld-musl-i386.so.1@' \
	-e 's@lib64/ld-linux-x86-64.so.2@lib/ld-musl-x86_64.so.1@' \
	-e 's@/usr@$(TT)@g' $$file && \
	echo '' >> $$file && \
	echo '#undef STANDARD_STARTFILE_PREFIX_1' >> $$file && \
	echo '#undef STANDARD_STARTFILE_PREFIX_2' >> $$file && \
	echo '#define STANDARD_STARTFILE_PREFIX_1 "$(TT)/lib/"' >> $$file && \
	echo '#define STANDARD_STARTFILE_PREFIX_2 ""' >> $$file && \
	touch $$file.orig ; \
	done
	cd ../$(DIR) ; sed -i '/MULTILIB_OSDIRNAMES/d' `find gcc/config -name t-linux64`
	cd ../$(DIR) ; sed -i '/^NATIVE_SYSTEM_HEADER_DIR/s@= .*@= $(TT)/include@' gcc/Makefile.in
	cd ../$(DIR) ; sed -i 's,\./fixinc\.sh,-c true,' gcc/Makefile.in
	cd ../$(DIR) ; sed -i '/#define STANDARD_INCLUDE_DIR/s@"/usr/include"@0@g' gcc/cppdefault.c
	cd ../$(DIR) ; sed -i "s@config.h.*@&\n#include \"$(TT)/include/limits.h\"@" gcc/config/host-linux.c
	cd ../$(DIR) ; sed -i "/typedef __SIZE_TYPE__ size_t/s@^.*@&\n#define __DEFINED_size_t@" gcc/ginclude/stddef.h
	cd ../$(DIR) ; sed -i '/include <link.h>/s@^.*@/\*&\*/@' gcc/unwind-dw2-fde-glibc.c
	CC="$(BUILD_ARCH)-gcc" CFLAGS="-D_GNU_SOURCE" \
	AR="$(BUILD_ARCH)-ar" RANLIB="$(BUILD_ARCH)-ranlib" \
	../$(DIR)/configure \
	--prefix=$(TT) \
	--host=$(BUILD_TRUE) \
	--build=$(BUILD_TRUE) \
	--target=$(BUILD_TRUE) \
	--with-local-prefix=$(TT) \
	--disable-shared \
	--enable-languages=c \
	--disable-multilib \
	--disable-libgomp \
	--disable-libssp \
	--disable-libmudflap \
	--disable-bootstrap
	make $(PM)
	make install
	ln -sv gcc $(TT)/bin/cc
	echo 'main(){}' | cc -x c - -v -lrt -Wl,--verbose
	readelf -l a.out | grep $(TT)
	rm -vf a.out

stage2: $(FILE) $(FILE1) $(FILE2) $(FILE3)
	$(sep_dir_build)

compile-stage2:
	cd ../$(DIR) ; dir=`unpack ../$(FILE1) silent` ; mv $$dir mpfr
	cd ../$(DIR) ; dir=`unpack ../$(FILE2) silent` ; mv $$dir gmp
	cd ../$(DIR) ; dir=`unpack ../$(FILE3) silent` ; mv $$dir mpc
	sed -i 's@linux-gnu@linux-musl@g' ../$(DIR)/config.sub ../$(DIR)/gmp/configfsf.sub ../$(DIR)/mpfr/config.sub ../$(DIR)/mpc/config.sub
	cd ../$(DIR) ; for file in $$(find gcc/config/i386 -name linux64.h -o -name linux.h) ; \
        do sed -i -e 's@lib/ld-linux.so.2@lib/ld-musl-i386.so.1@' \
        -e 's@lib64/ld-linux-x86-64.so.2@lib/ld-musl-x86_64.so.1@' $$file ; done
	cd ../$(DIR) ; sed -i '/MULTILIB_OSDIRNAMES/d' `find gcc/config -name t-linux64`
	cd ../$(DIR) ; sed -i 's/install_to_$$(INSTALL_DEST) //' libiberty/Makefile.in
	cd ../$(DIR) ; sed -i '/   *attribute_mode/s@attr@#&@' gcc/config/i386/i386-builtin-types.awk
	cd ../$(DIR) ; sed -i '/include <link.h>/s@^.*@/\*&\*/@' gcc/unwind-dw2-fde-glibc.c
	cd ../$(DIR) ; sed -i 's,\./fixinc\.sh,-c true,' gcc/Makefile.in
	hush -c 'CC="gcc" CFLAGS="-D_GNU_SOURCE" ../$(DIR)/configure \
	--prefix=/usr \
	--host=$(BUILD_TRUE) \
	--build=$(BUILD_TRUE) \
	--target=$(BUILD_TRUE) \
	--libexecdir=/usr/lib \
	--disable-shared \
	--disable-libgomp \
	--disable-libssp \
	--disable-libmudflap \
	--enable-languages=c \
	--disable-bootstrap \
	--with-system-zlib \
	--disable-multilib'
	hush -c 'make $(PM)'
	hush -c 'make install'
	ln -sf ../usr/bin/cpp /lib
	ln -sf gcc /usr/bin/cc
	echo 'main(){}' | cc -x c - -v -lrt -Wl,--verbose
	rm -f a.out

clean:
	-rm -rf $(DIR)
	-rm -rf $(NM)-build

.PHONY: compile-stage1 clean compile-prebuild compile-stage2
