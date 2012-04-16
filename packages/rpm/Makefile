# rpm Makefile

NM= rpm
VRS= 5.3.11
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
MD5-$(FILE)= 7c1f624c22143324ee372dffd1a209c2

PATCH= rpm-musl.patch
PATCH1= rpm-no-error.patch

include $(MY_ROOT)/scripts/functions.mk

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	patch -Np1 -i ../$(PATCH)
	patch -Np1 -i ../$(PATCH1)
	sed -i 's@-fstack-protector@@' configure
	sed -i 's@_prefix}/info@_datadir}/info@' macros/macros.in
	sed -i 's@_prefix}/man@_datadir}/man@' macros/macros.in
	sed -i '/^%_usr/s,@usrprefix@,/,' macros/macros.in
	sed -i '/^%_prefix/s,@prefix@,/,' macros/macros.in
	$(musl_prep)
	CC="gcc -D__musl__" ./configure --prefix='' \
	  --disable-openmp \
	  --disable-nls \
	  --disable-shared \
	  --enable-static \
	  --with-expat=external \
	  --with-file=external \
	  --with-lua=no \
	  --with-neon=external \
	  --with-pcre=external \
	  --with-popt=external \
	  --without-pthreads \
	  --without-selinux \
	  --with-zlib
	make $(PM)
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
