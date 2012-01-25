# Make Makefile

NM= make
VRS= 3.82
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
MD5-$(FILE)= 1a11100f3c63fcf5753818e59d63088f

# Targets

include $(MY_ROOT)/scripts/functions.mk

prebuild: $(FILE)
	$(std_build)

compile-prebuild:
	./configure --prefix=$(TT)
	make $(PM)
	make install
	ln -vs make $(TT)/bin/gmake

stage1: $(FILE)
	$(std_build)

compile-stage1:
	sed -i 's@linux-gnu@linux-musl@g' config/config.sub
	CC="gcc -D__BEOS__" \
	./configure --prefix=$(TT) \
	--disable-nls \
	--host=$(BUILD_TRUE) \
	--build=$(BUILD_TRUE) \
	--target=$(BUILD_TRUE)
	make $(PM)
	make install

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	sed -i 's@linux-gnu@linux-musl@g' config/config.sub
	hush -c 'CC="gcc -D__BEOS__" \
	./configure --prefix=/usr \
	--disable-nls \
	--host=$(BUILD_TRUE) \
	--build=$(BUILD_TRUE) \
	--target=$(BUILD_TRUE)'
	hush -c 'make $(PM)'
	hush -c 'make install'

clean:
	-rm -rf $(DIR)

.PHONY: compile-prebuild compile-stage1 clean compile-stage2
