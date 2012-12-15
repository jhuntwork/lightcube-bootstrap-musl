# Gcc Makefile

NM= gcc
VRS= 4.2.4
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://ftp.gnu.org/gnu/gcc/$(DIR)/$(FILE)
SHA256-$(FILE)= afba845e2d38547a63bd3976e90245c81ea176786f9e6966339c6d3761f1133a

include $(MY_ROOT)/scripts/functions.mk

stage0: $(FILE)
	$(sep_dir_build)

compile-stage0:
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
	--enable-languages=c
	make $(PM)
	make install

stage1: $(FILE)
	$(sep_dir_build)

compile-stage1:
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
	--enable-languages=c,c++
	make $(PM)
	make install
	ln -sf gcc $(TT)/bin/cc
	echo 'main(){}' | cc -x c - -v -lrt -Wl,--verbose
	readelf -l a.out | grep $(TT)
	rm -vf a.out

stage2: Makefile $(FILE)
	$(sep_dir_build)

compile-stage2:
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
	cd ../$(DIR) ; sed -i 's,\./fixinc\.sh,-c true,' gcc/Makefile.in
	cd ../$(DIR) ; rm -rf libstdc++-v3/config/os/gnu-linux && ln -s generic libstdc++-v3/config/os/gnu-linux
	CFLAGS="$(CFLAGS) -fPIC" ../$(DIR)/configure \
	--prefix='' \
	--libexecdir=/lib \
	--enable-threads=posix \
	--disable-tls \
	--disable-bootstrap \
	--disable-libmudflap \
	--disable-multilib \
	--enable-languages=c,c++
	make $(PM) BOOT_LDFLAGS="-static" LDFLAGS="-static"
	make install
	ln -sf ../bin/cpp /lib
	ln -sf gcc /bin/cc
	echo 'main(){}' | cc -x c - -v -lrt -Wl,--verbose
	rm -f a.out
