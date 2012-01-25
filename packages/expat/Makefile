# expat Makefile

NM= expat
VRS= 2.0.1
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
MD5-$(FILE)= ee8b492592568805593f81f8cdf2a04c

# Targets

include $(MY_ROOT)/scripts/functions.mk

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	sed -i 's@linux-gnu@linux-musl@g' conftools/config.sub
	hush -c 'CC="gcc" ./configure --prefix=/usr \
    --host=$(BUILD_TRUE) \
    --build=$(BUILD_TRUE) \
    --target=$(BUILD_TRUE)'
	hush -c 'make $(PM)'
	hush -c 'make install'

clean:
	-rm -rf $(DIR)

.PHONY: clean compile-stage2
