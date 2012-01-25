# File Makefile

NM= file
VRS= 5.09
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= ftp://ftp.astron.com/pub/$(NM)/$(FILE)
MD5-$(FILE)= 6fd7cd6c4281e68fe9ec6644ce0fac6f

# Targets

include $(MY_ROOT)/scripts/functions.mk

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	sed -i '/memory.h/d' src/ascmagic.c src/encoding.c
	sed -i 's@linux-gnu@linux-musl@g' config.sub
	hush -c 'CC="gcc" ./configure --prefix=/usr \
    --host=$(BUILD_TRUE) \
    --build=$(BUILD_TRUE) \
    --target=$(BUILD_TRUE)'
	hush -c 'make V=1 $(PM)'
	hush -c 'make install'

clean:
	-rm -rf $(DIR)

.PHONY: clean compile-stage2
