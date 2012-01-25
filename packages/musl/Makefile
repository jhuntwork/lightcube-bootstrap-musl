# musl Makefile

NM= musl
VRS= 20111219
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://www.etalabs.net/musl/releases/$(FILE)
MD5-$(FILE)= 2ec6a3e1009a8ca7d87996b32a3037a1

FILE1= config-x86
FILE2= config-x86_64

# Targets

include $(MY_ROOT)/scripts/functions.mk

stage1: $(FILE)
	$(std_build)

compile-stage1:
	install ../$(FILE2) config.mak
	sed -i '/prefix/s@=.*@= $(TT)@' config.mak
	sed -i '/syslibdir/s@=.*@= $(TT)/lib@' config.mak
	make CC=$(BUILD_ARCH)-gcc CROSS_COMPILE=$(BUILD_ARCH)- libdir=$(TT)/lib $(PM)
	make CC=$(BUILD_ARCH)-gcc CROSS_COMPILE=$(BUILD_ARCH)- libdir=$(TT)/lib install
	echo 'main(){}' | $(BUILD_ARCH)-gcc -x c - -v -lrt -Wl,--verbose
	readelf -l a.out | grep $(TT)
	rm -vf a.out

stage2: $(FILE)
	$(std_build)

compile-stage2:
	install ../$(FILE2) config.mak
	make CC=gcc $(PM)
	make install
	rm -f /lib/ld-musl-x86_64.so.1
	mv /usr/lib/libc.* /lib
	ln -s libc.so /lib/ld-musl-x86_64.so.1	
	mv $(TT)/bin/ld $(TT)/bin/ld-old
	mv $(TT)/$$(gcc -dumpmachine)/bin/ld $(TT)/$$(gcc -dumpmachine)/bin/ld-old
	mv $(TT)/bin/ld-new $(TT)/bin/ld
	ln -s $(TT)/bin/ld $(TT)/$$(gcc -dumpmachine)/bin/ld
	gcc -dumpspecs | sed \
	-e 's@$(TT)@@g' \
	-e '/^\*cpp:$$/{n;s,$$, -isystem /usr/include,}' \
	-e '/\*startfile_prefix_spec:/{n;s@.*@/usr/lib/ @}' \
	> `dirname $$(gcc --print-libgcc-file-name)`/specs
	echo 'main(){}' | cc -x c - -v -lrt -Wl,--verbose
	rm -f a.out

clean:
	-rm -rf $(DIR)

.PHONY: compile-stage1 compile-prebuild clean compile-stage2
