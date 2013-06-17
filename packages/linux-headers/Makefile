NM= linux
VRS= 3.9
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.xz
URL-$(FILE)= http://www.kernel.org/pub/linux/kernel/v3.x/$(FILE)
SHA256-$(FILE)= 60bc3e64ee5dc778de2cd7cd7640abf518a4c9d4f31b8ed624e16fad53f54541

PATCH= linux-noperl-headers.patch

include $(MY_ROOT)/scripts/functions.mk

stage0: $(FILE)
	$(std_build)

compile-stage0:
	patch -Np1 -i ../$(PATCH)
	# Fix a non-posix issue with a script
	sed -i 's@ ERR@@' scripts/link-vmlinux.sh
	install -dv $(TT)/include
	make mrproper
	make INSTALL_HDR_PATH=dest headers_install
	cp -rv dest/include/* $(TT)/include

stage2: $(FILE)
	$(std_build)

compile-stage2:
	patch -Np1 -i ../$(PATCH)
	# Fix a non-posix issue with a script
	sed -i 's@ ERR@@' scripts/link-vmlinux.sh
	make mrproper
	make INSTALL_HDR_PATH=dest HOSTCFLAGS="-D_GNU_SOURCE" headers_install
	cp -rv dest/include/* /include
