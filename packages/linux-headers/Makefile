NM= linux
VRS= 3.14.4
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.xz
URL-$(FILE)= http://www.kernel.org/pub/linux/kernel/v3.x/$(FILE)
SHA256-$(FILE)= 65850a8c799c695ab43aab1bc7a98f2631092b696ee07db348cfca75450ad717

include $(MY_ROOT)/scripts/functions.mk

stage0: $(FILE)
	$(std_build)

compile-stage0:
	# Fix a non-posix issue with a script
	sed -i 's@ ERR@@' scripts/link-vmlinux.sh
	install -dv $(TT)/include
	make mrproper
	make INSTALL_HDR_PATH=dest headers_install
	cp -rv dest/include/* $(TT)/include

stage2: $(FILE)
	$(std_build)

compile-stage2:
	# Fix a non-posix issue with a script
	sed -i 's@ ERR@@' scripts/link-vmlinux.sh
	make mrproper
	make INSTALL_HDR_PATH=dest HOSTCFLAGS="-D_GNU_SOURCE" headers_install
	cp -rv dest/include/* /include
