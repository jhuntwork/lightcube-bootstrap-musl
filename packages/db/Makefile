# DB Makefile

NM= db
VRS= 5.1.19
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
MD5-$(FILE)= 76fcbfeebfcd09ba0b4d96bfdf8d884d

include $(MY_ROOT)/scripts/functions.mk

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	$(musl_prep)
	cd build_unix ; ../dist/configure \
	--prefix='' \
	--enable-compat185 \
	--enable-dbm \
	--enable-static \
	--disable-shared
	cd build_unix ; make $(PM)
	cd build_unix ; make docdir=/share/doc/$(DIR) install
	install -d /include/db51
	for file in /include/db*.h ; do ln -f $$file /include/db51/ ; done
	rm -rf /share/doc/$(DIR)

clean:
	-rm -rf $(DIR)

.PHONY: clean compile-stage2
