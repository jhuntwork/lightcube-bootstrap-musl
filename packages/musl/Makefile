# musl Makefile

NM= musl
VRS= 0.8.9
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://www.etalabs.net/musl/releases/$(FILE)
MD5-$(FILE)= 1dfb3ba92ec08073bb982efc60b058cb

FILE1= config-x86_64

include $(MY_ROOT)/scripts/functions.mk

stage1: $(FILE)
	$(std_build)

compile-stage1:
	install ../$(FILE1) config.mak
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
	install ../$(FILE1) config.mak
	make CC=gcc $(PM)
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
	rm -f a.out

clean:
	-rm -rf $(DIR)

.PHONY: compile-stage1 compile-prebuild clean compile-stage2
