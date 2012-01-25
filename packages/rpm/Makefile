# rpm Makefile

NM= rpm
VRS= 5.3.11
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
MD5-$(FILE)= 7c1f624c22143324ee372dffd1a209c2

# Targets

include $(MY_ROOT)/scripts/functions.mk

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	# Comment out use of program_invocation_name
	sed -i -e '161 s@^@/*@' -e '179 s@^@*/@' misc/setproctitle.c
	sed -i 's@-fstack-protector@@' configure
	sed -i 's@stat64 sb@stat sb@' rpmio/fts.c
	sed -i 's@_prefix}/info@_datadir}/info@' macros/macros.in
	sed -i 's@_prefix}/man@_datadir}/man@' macros/macros.in
	sed -i 's@typedef.*	AVDIR@typedef struct __dirstream *	AVDIR@' rpmio/rpmdir.h
	sed -i 's@typedef.*	DAVDIR@typedef struct __dirstream *	DAVDIR@' rpmio/rpmdir.h
	sed -i '121,123d' rpmio/rpmsq.c
	sed -i "443 s@.*@&\n#else\n	int attr;@" rpmio/yarn.c
	sed -i 's@linux-gnu@linux-musl@g' syck/config/config.sub config.sub
	hush -c 'CFLAGS="$$CFLAGS -D_STAT_VER=0 -D__UCLIBC__" \
    CC="gcc" ./configure --prefix=/usr \
    --host=$(BUILD_TRUE) \
    --build=$(BUILD_TRUE) \
    --target=$(BUILD_TRUE) \
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
