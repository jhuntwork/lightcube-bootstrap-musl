# beecrypt Makefile

NM= beecrypt
VRS= 4.2.1
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
MD5-$(FILE)= 8441c014170823f2dff97e33df55af1e

# Targets

include $(MY_ROOT)/scripts/functions.mk

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	sed -i 's@linux-gnu@linux-musl@g' config.sub
	sed -i -e 's@cppglue.cxx@@g' -e 's@cppglue.lo@@g' Makefile.in
	sed -i "6900 s@.*@&\nac_preproc_ok=true@" configure
	sed -i 's@tag=CXX@tag=CC@g' Makefile.in
	hush -c 'CC=gcc ./configure --prefix=/usr \
    --disable-openmp \
    --without-cplusplus \
    --host=$(BUILD_TRUE) \
    --build=$(BUILD_TRUE) \
    --target=$(BUILD_TRUE)'
	hush -c 'make $(PM)'
	hush -c 'make install'

clean:
	-rm -rf $(DIR)

.PHONY: clean compile-stage2
