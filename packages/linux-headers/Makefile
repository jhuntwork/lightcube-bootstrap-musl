# Linux-headers Makefile

NM= linux
VRS= 3.3.2
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://www.kernel.org/pub/linux/kernel/v3.0/$(FILE)
MD5-$(FILE)= cb5f959dfb3009bcc2a6e4ebf162174e

PATCH= linux-noperl-headers.patch

include $(MY_ROOT)/scripts/functions.mk

prebuild: $(FILE)
	$(std_build)

compile-prebuild:
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

.PHONY: compile-prebuild clean compile-stage2
