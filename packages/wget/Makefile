# Wget Makefile

NM= wget
VRS= 1.13.4
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.gz
URL-$(FILE)= http://ftp.gnu.org/gnu/$(NM)/$(FILE)
MD5-$(FILE)= 1df489976a118b9cbe1b03502adbfc27

# Targets

include $(MY_ROOT)/scripts/functions.mk

ftpget:
	@cd $(SRC) ; sh $(MY_ROOT)/scripts/ftpget $(NM) $(VRS)
	@touch $@

prebuild: ftpget $(FILE)
	$(std_build)

compile-prebuild:
	cp Makefile.in Makefile.in.bak
	sed -e '/^SUBDIRS/s@ doc@@' -e '/^install:/s@ install.info@@' \
	-e 's/@COMMENT_IF_NO_POD2MAN@install.man//' Makefile.in.bak > Makefile.in
	./configure --prefix=$(TT) --disable-nls --without-ssl
	make $(PM)
	make install

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	sed -i 's@linux-gnu@linux-musl@g' build-aux/config.sub
	CC="gcc" ./configure --prefix=/usr \
	--host=$(BUILD_TRUE) \
	--build=$(BUILD_TRUE) \
	--target=$(BUILD_TRUE) \
	--disable-ipv6 \
	--sysconfdir=/etc \
    --with-ssl=openssl \
	--disable-nls
	make -C src wget $(PM)
	install -m755 src/wget /usr/bin/wget
	# Remove the busybox wget
	rm -f /bin/wget
	echo "ca_certificate = /etc/ssl/certs/ca-bundle.crt" >> /etc/wgetrc

clean:
	-rm -rf $(DIR)

.PHONY: compile-prebuild clean compile-stage2
