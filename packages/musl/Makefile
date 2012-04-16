# musl Makefile

NM= musl
VRS= 0.8.7-20120414
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
MD5-$(FILE)= 01fe8338a72954e21414f6f2c11d5b0e

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
	sed -i "/getdate /s@.*@&\nint stime(time_t *t);@" include/time.h
	sed -i "s@^#ifdef _GNU_SOURCE.*@&\nint daemon(int nochdir, int noclose);\nint getdomainname(char *name, size_t len);@" include/unistd.h
	sed -i "/^pid_t/s@.*@&\n\n#ifdef _GNU_SOURCE\nvoid cfmakeraw(struct termios *t);\nint cfsetspeed(struct termios *, speed_t);\n#endif@" include/termios.h
	echo "#undef powerof2" >>include/sys/param.h
	echo "#define powerof2(x) ((((x) - 1) & (x)) == 0)" >>include/sys/param.h
	echo "#undef __CONCAT" >>include/sys/param.h
	echo "#define __CONCAT(x,y)   x ## y" >>include/sys/param.h
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
