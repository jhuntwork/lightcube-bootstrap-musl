# openssl Makefile

NM= openssl
VRS= 1.0.1g
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://www.openssl.org/source/$(FILE)
SHA256-$(FILE)= 53cb818c3b90e507a8348f4f5eaedb05d8bfe5358aabb508b7263cc670c3e028

PATCH= $(NM)-parallel-build.patch

include $(MY_ROOT)/scripts/functions.mk

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	patch -Np1 -i ../$(PATCH)
	sed -i '/^"linux-x86_64/s/-DTERMIO/-DTERMIOS/' Configure
	sed -i '/^"linux-elf/s/-DTERMIO/-DTERMIOS/' Configure
	sed -i 's/defined(linux)/0/' crypto/ui/ui_openssl.c
	./config \
          --prefix=/ \
          --libdir=/lib \
          --openssldir=/etc/ssl \
          shared zlib no-dso $$CFLAGS -D_HACK_DSO_BEOS
	make $(PM)
	make MANDIR=/share/man install
	install -d /etc/ssl/certs
	install -m 0644 ../ca-bundle.crt /etc/ssl/certs/
