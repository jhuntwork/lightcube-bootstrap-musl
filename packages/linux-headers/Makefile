# Linux-headers Makefile

NM= linux
VRS= 2.6.39.3
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
MD5-$(FILE)= 5afede829846587e798f2631c2ece84f

# Targets

include $(MY_ROOT)/scripts/functions.mk

prebuild: $(FILE)
	$(std_build)

compile-prebuild:
	install -dv $(TT)/include
	make mrproper
	make headers_check
	make INSTALL_HDR_PATH=dest headers_install
	cp -rv dest/include/* $(TT)/include

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	make mrproper
	make HOSTCFLAGS="-D_GNU_SOURCE" headers_check
	make INSTALL_HDR_PATH=dest HOSTCFLAGS="-D_GNU_SOURCE" headers_install
	cp -rv dest/include/* /usr/include

clean:
	-rm -rf $(DIR)

.PHONY: compile-prebuild clean compile-stage2
