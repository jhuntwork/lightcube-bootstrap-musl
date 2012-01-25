# DB Makefile

NM= db
VRS= 5.1.19
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
MD5-$(FILE)= 76fcbfeebfcd09ba0b4d96bfdf8d884d

# Targets

include $(MY_ROOT)/scripts/functions.mk

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	find . -name config.sub -exec sed -i 's@linux-gnu@linux-musl@g' '{}' \;
	hush -c 'cd build_unix ; CC="gcc" ../dist/configure --prefix=/usr \
	  --enable-compat185 --libdir=/usr/$(MY_LIBDIR) --enable-dbm \
	  --enable-static --enable-shared \
	  --host=$(BUILD_TRUE) \
	  --build=$(BUILD_TRUE) \
	  --target=$(BUILD_TRUE)'
	hush -c 'cd build_unix ; make $(PM)'
	hush -c 'cd build_unix ; make docdir=/usr/share/doc/$(DIR) install'
	rm -rf /usr/share/doc/$(DIR)

clean:
	-rm -rf $(DIR)

.PHONY: clean compile-stage2
