# Gcc Makefile

NM= gcc
VRS= 4.5.3
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://ftp.gnu.org/gnu/gcc/$(DIR)/$(FILE)
MD5-$(FILE)= 8e0b5c12212e185f3e4383106bfa9cc6

FILE1= mpfr-3.1.0.tar.bz2
URL-$(FILE1)= $(HTTP)/mpfr/$(FILE1)
MD5-$(FILE1)= 238ae4a15cc3a5049b723daef5d17938

FILE2= gmp-5.0.4.tar.bz2
URL-$(FILE2)= ftp://ftp.gmplib.org/pub/gmp-5.0.4/$(FILE2)
MD5-$(FILE2)= 50c3edcb7c9438e04377ee9a1a061b79

FILE3= mpc-0.9.tar.gz
URL-$(FILE3)= $(HTTP)/mpc/$(FILE3)
MD5-$(FILE3)= 0d6acab8d214bd7d1fbbc593e83dd00d

include $(MY_ROOT)/scripts/functions.mk

prebuild: $(FILE) $(FILE1) $(FILE2) $(FILE3)
	$(sep_dir_build)

compile-prebuild:
	cd ../$(DIR) ; mv $$(unpack ../$(FILE1) silent) mpfr
	cd ../$(DIR) ; mv $$(unpack ../$(FILE2) silent) gmp
	cd ../$(DIR) ; mv $$(unpack ../$(FILE3) silent) mpc
	$(musl_prep)
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
	--enable-languages=c \
	--with-mpfr-include=`pwd`/../$(DIR)/mpfr/src \
	--with-mpfr-lib=`pwd`/mpfr/src/.libs
	make $(PM)
	make install

stage1: $(FILE) $(FILE1) $(FILE2) $(FILE3)
	$(sep_dir_build)

compile-stage1:
	cd ../$(DIR) ; mv $$(unpack ../$(FILE1) silent) mpfr
	cd ../$(DIR) ; mv $$(unpack ../$(FILE2) silent) gmp
	cd ../$(DIR) ; mv $$(unpack ../$(FILE3) silent) mpc
	$(musl_prep)
	cat ../$(DIR)/gcc/limitx.h ../$(DIR)/gcc/glimits.h ../$(DIR)/gcc/limity.h > \
	   `dirname $$($(BUILD_ARCH)-gcc -print-libgcc-file-name)`/include/limits.h
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
	cd ../$(DIR) ; sed -i '/#define STANDARD_INCLUDE_DIR/s@"/usr/include"@0@g' gcc/cppdefault.c
	cd ../$(DIR) ; sed -i '/include <link.h>/s@^.*@/\*&\*/@' gcc/unwind-dw2-fde-glibc.c
	cd ../$(DIR) ; sed -i 's,\./fixinc\.sh,-c true,' gcc/Makefile.in
	cd ../$(DIR) ; rm -rf libstdc++-v3/config/os/gnu-linux && ln -s generic libstdc++-v3/config/os/gnu-linux
	CC="$(BUILD_ARCH)-gcc" CFLAGS="-D_GNU_SOURCE" \
	AR="$(BUILD_ARCH)-ar" RANLIB="$(BUILD_ARCH)-ranlib" \
	../$(DIR)/configure \
	--prefix=$(TT) \
	--with-local-prefix=$(TT) \
	--disable-shared \
	--disable-multilib \
	--disable-libgomp \
	--disable-libssp \
	--disable-libmudflap \
	--disable-bootstrap \
	--enable-languages=c,c++ \
	--with-mpfr-include=`pwd`/../$(DIR)/mpfr/src \
	--with-mpfr-lib=`pwd`/mpfr/src/.libs
	make $(PM)
	make install
	ln -sf gcc $(TT)/bin/cc
	echo 'main(){}' | cc -x c - -v -lrt -Wl,--verbose
	readelf -l a.out | grep $(TT)
	rm -vf a.out

stage2: Makefile $(FILE) $(FILE1) $(FILE2) $(FILE3)
	$(sep_dir_build)

compile-stage2:
	cd ../$(DIR) ; mv $$(unpack ../$(FILE1) silent) mpfr
	cd ../$(DIR) ; mv $$(unpack ../$(FILE2) silent) gmp
	cd ../$(DIR) ; mv $$(unpack ../$(FILE3) silent) mpc
	$(musl_prep)
	cd ../$(DIR) ; for file in $$(find gcc/config/i386 -name linux64.h -o -name linux.h) ; \
        do sed -i -e 's@lib/ld-linux.so.2@lib/ld-musl-i386.so.1@' \
	-e 's@/usr@/@g' \
        -e 's@lib64/ld-linux-x86-64.so.2@lib/ld-musl-x86_64.so.1@' $$file ; done
	cd ../$(DIR) ; sed -i '/MULTILIB_OSDIRNAMES/d' `find gcc/config -name t-linux64`
	cd ../$(DIR) ; sed -i '/^NATIVE_SYSTEM_HEADER_DIR/s@= .*@= /include@' gcc/Makefile.in
	cd ../$(DIR) ; sed -i '/#define STANDARD_INCLUDE_DIR/s@"/usr/include"@"/include"@g' gcc/cppdefault.c
	cd ../$(DIR) ; sed -i 's/install_to_$$(INSTALL_DEST) //' libiberty/Makefile.in
	cd ../$(DIR) ; sed -i '/include <link.h>/s@^.*@/\*&\*/@' gcc/unwind-dw2-fde-glibc.c
	cd ../$(DIR) ; sed -i '/   *attribute_mode/s@attr@#&@' gcc/config/i386/i386-builtin-types.awk
	cd ../$(DIR) ; sed -i 's,\./fixinc\.sh,-c true,' gcc/Makefile.in
	cd ../$(DIR) ; rm -rf libstdc++-v3/config/os/gnu-linux && ln -s generic libstdc++-v3/config/os/gnu-linux
	../$(DIR)/configure \
	--prefix='' \
	--libexecdir=/lib \
	--disable-shared \
	--disable-libgomp \
	--disable-libssp \
	--disable-libmudflap \
	--enable-languages=c,c++ \
	--disable-bootstrap \
	--with-system-zlib \
	--disable-multilib \
	--with-mpfr-include=`pwd`/../$(DIR)/mpfr/src \
	--with-mpfr-lib=`pwd`/mpfr/src/.libs
	make $(PM) BOOT_LDFLAGS="-static" LDFLAGS="-static"
	make install
	ln -sf ../bin/cpp /lib
	ln -sf gcc /bin/cc
	echo 'main(){}' | cc -x c - -v -lrt -Wl,--verbose
	rm -f a.out

clean:
	-rm -rf $(DIR)
	-rm -rf $(NM)-build

.PHONY: compile-stage1 clean compile-prebuild compile-stage2
