# cvs Makefile

# This package is needed for the ca bundle in openssl

NM= cvs
VRS= 1.11.23
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://ftp.gnu.org/non-gnu/$(NM)/source/stable/$(VRS)/$(FILE)
MD5-$(FILE)= 0213ea514e231559d6ff8f80a34117f0

PATCH= $(DIR)-zlib-1.patch
URL-$(PATCH)= http://www.linuxfromscratch.org/patches/blfs/svn/$(PATCH)
MD5-$(PATCH)= 4fee2157a3c347aed8a7d2411fd500c9

# Targets

include $(MY_ROOT)/scripts/functions.mk

stage2: Makefile $(FILE) $(PATCH)
	$(std_build)

compile-stage2:
	patch -Np1 -i ../$(PATCH)
	sed -i 's/getline /get_line /' lib/getline.c lib/getline.h
	hush -c 'CC="gcc" ./configure --prefix=/usr \
    --host=$(BUILD_TRUE) \
    --build=$(BUILD_TRUE) \
    --target=$(BUILD_TRUE) \
    --with-editor=vi'
	hush -c 'make $(PM)'
	hush -c 'make install'

clean:
	-rm -rf $(DIR)

.PHONY: clean compile-stage2
