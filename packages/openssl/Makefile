# OpenSSL Makefile

NM= openssl
VRS= 1.0.0e
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://www.openssl.org/source/$(FILE)
MD5-$(FILE)= 7040b89c4c58c7a1016c0dfa6e821c86

FILE1= mkcabundle.pl

# Targets

include $(MY_ROOT)/scripts/functions.mk

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	sed -i -e 's@undef  TERMIOS@define  TERMIOS@' -e 's@define TERMIO$$@undef TERMIO@' crypto/ui/ui_openssl.c
	sed -i 's@-DTERMIO @-DTERMIOS @' Configure
	sed -i '/memory.h/d' crypto/pkcs7/bio_pk7.c
	sed -i '/HAVE_DLINFO 1/d' crypto/dso/dso_dlfcn.c
	sed -i "s@-O3 -Wall@& $$CFLAGS -fno-strict-aliasing@" Configure
	hush -c './config  --openssldir=/etc/ssl --prefix=/usr shared zlib-dynamic'
	hush -c 'make MANDIR=/usr/share/man'
	hush -c 'make MANDIR=/usr/share/man install'
	install -d /etc/ssl/certs
	perl ../$(FILE1) >/etc/ssl/certs/ca-bundle.crt

clean:
	-rm -rf $(DIR)

.PHONY: clean compile-stage2
