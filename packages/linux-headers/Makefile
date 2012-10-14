# Linux-headers Makefile

NM= linux
VRS= 3.6.2
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://www.kernel.org/pub/linux/kernel/v3.0/$(FILE)
SHA256-$(FILE)= 02af064f36dd9572e46c7b0b1b9b6a5fa18cab7f93dc7f002d3eb16cab61dc2a

PATCH= linux-noperl-headers.patch

include $(MY_ROOT)/scripts/functions.mk

stage0: $(FILE)
	$(std_build)

compile-stage0:
	patch -Np1 -i ../$(PATCH)
	install -dv $(TT)/include
	# Fix a non-posix issue with a script
	sed -i 's@ ERR@@' scripts/link-vmlinux.sh
	make mrproper
	make INSTALL_HDR_PATH=dest headers_install
	cp -rv dest/include/* $(TT)/include

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	patch -Np1 -i ../$(PATCH)
	# Fix a non-posix issue with a script
	sed -i 's@ ERR@@' scripts/link-vmlinux.sh
	make mrproper
	make INSTALL_HDR_PATH=dest HOSTCFLAGS="-D_GNU_SOURCE" headers_install
	cp -rv dest/include/* /include

clean:
	-rm -rf $(DIR)

.PHONY: compile-stage0 compile-stage2 clean
