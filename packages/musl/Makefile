# musl Makefile

NM= musl
VRS= 0.9.6
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://www.etalabs.net/musl/releases/$(FILE)
SHA256-$(FILE)= c447b239ae1bbcd6750a077c1170a92e7a5ea19cc327c3cf5b821f1b677ca208

include $(MY_ROOT)/scripts/functions.mk

stage1: $(FILE)
	$(std_build)

compile-stage1:
	# -O3 boosts performance of some features, such as regex
	sed -i 's@-Os@-O3@g' configure
	CFLAGS="" CC=$(BUILD_ARCH)-gcc \
	./configure \
	  --prefix=$(TT) \
	  --syslibdir=$(TT)/lib
	# -ffloat-store contributes significantly to size of libc.a
	sed -i 's@-ffloat-store@@' config.mak
	make CROSS_COMPILE=$(BUILD_ARCH)- libdir=$(TT)/lib $(PM)
	make CROSS_COMPILE=$(BUILD_ARCH)- libdir=$(TT)/lib install
	echo 'main(){}' | $(BUILD_ARCH)-gcc -x c - -v -lrt -Wl,--verbose
	readelf -l a.out | grep $(TT)

stage2: $(FILE)
	$(std_build)

compile-stage2:
	# -O3 boosts performance of some features, such as regex
	sed -i 's@-Os@-O3@g' configure
	CFLAGS="" ./configure \
	  --prefix=/
	# -ffloat-store contributes significantly to size of libc.a
	sed -i 's@-ffloat-store@@' config.mak
	make $(PM)
	make install
	mv $(TT)/bin/ld $(TT)/bin/ld-old
	mv $(TT)/$$(gcc -dumpmachine)/bin/ld $(TT)/$$(gcc -dumpmachine)/bin/ld-old
	mv $(TT)/bin/ld-new $(TT)/bin/ld
	ln -s $(TT)/bin/ld $(TT)/$$(gcc -dumpmachine)/bin/ld
	gcc -dumpspecs | sed \
	 -e 's@$(TT)@@g' \
	 -e '/^\*cpp:$$/{n;s,$$, -isystem /include,}' \
	 -e '/\*startfile_prefix_spec:/{n;s@.*@/lib/ @}' \
	 > `dirname $$(gcc --print-libgcc-file-name)`/specs
	echo 'main(){}' | cc -x c - -v -lrt -Wl,--verbose
	readelf -l a.out | grep "interpreter: /lib/"

clean:
	-rm -rf $(DIR)

.PHONY: compile-stage1 compile-prebuild clean compile-stage2
