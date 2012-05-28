# Linux-headers Makefile

NM= linux
VRS= 3.3.2
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://www.kernel.org/pub/linux/kernel/v3.0/$(FILE)
SHA256-$(FILE)= 4527f29d8a08ae57e9e73d4d1bd61192e36dbaabfe007c25152a7d74648bef01

PATCH= linux-noperl-headers.patch

include $(MY_ROOT)/scripts/functions.mk

stage0: $(FILE)
	$(std_build)

compile-stage0:
	patch -Np1 -i ../$(PATCH)
	install -dv $(TT)/include
	make mrproper
	make INSTALL_HDR_PATH=dest headers_install
	cp -rv dest/include/* $(TT)/include

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	patch -Np1 -i ../$(PATCH)
	make mrproper
	make INSTALL_HDR_PATH=dest HOSTCFLAGS="-D_GNU_SOURCE" headers_install
	cp -rv dest/include/* /include

clean:
	-rm -rf $(DIR)

.PHONY: compile-stage0 compile-stage2 clean
