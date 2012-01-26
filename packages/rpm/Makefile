# rpm Makefile

NM= rpm
VRS= 5.3.11
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
MD5-$(FILE)= 7c1f624c22143324ee372dffd1a209c2

PATCH= rpm-musl.patch

# Targets

include $(MY_ROOT)/scripts/functions.mk

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	patch -Np1 -i ../$(PATCH)
	sed -i 's@-fstack-protector@@' configure
	sed -i 's@_prefix}/info@_datadir}/info@' macros/macros.in
	sed -i 's@_prefix}/man@_datadir}/man@' macros/macros.in
	sed -i 's@linux-gnu@linux-musl@g' `find . -name config.sub -o -name config.guess`
	hush -c 'CFLAGS="$$CFLAGS -g" LDFLAGS="-g" CC="gcc" ./configure --prefix=/usr \
	  --disable-openmp \
	  --disable-nls \
	  --with-expat=external \
	  --with-file=external \
	  --with-lua=no \
	  --with-neon=external \
	  --with-openssl \
	  --with-pcre=external \
	  --with-popt=external \
	  --without-pthreads \
	  --with-python \
	  --without-selinux \
	  --with-zlib'
	hush -c 'make $(PM)'
	hush -c 'make install'

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
