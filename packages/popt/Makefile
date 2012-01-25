# popt Makefile

NM= popt
VRS= 1.16
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://rpm5.org/files/$(NM)/$(FILE)
MD5-$(FILE)= 3743beefa3dd6247a73f8f7a32c14c33

# Targets

include $(MY_ROOT)/scripts/functions.mk

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	sed -i 's@linux-gnu@linux-musl@g' config.sub	
	hush -c 'CC="gcc" ./configure --prefix=/usr \
    --host=$(BUILD_TRUE) \
    --build=$(BUILD_TRUE) \
    --target=$(BUILD_TRUE)'
	hush -c 'make $(PM)'
	hush -c 'make install'

clean:
	-rm -rf $(DIR)

.PHONY: clean compile-stage2
