# File Makefile

NM= file
VRS= 5.11
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= ftp://ftp.astron.com/pub/$(NM)/$(FILE)
SHA256-$(FILE)= c70ae29a28c0585f541d5916fc3248c3e91baa481f63d7ccec53d1534cbcc9b7

include $(MY_ROOT)/scripts/functions.mk

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	$(musl_prep)
	# Move the datadir location from /usr/share/misc to /usr/share/file
	sed -i 's/misc/file/' configure
	./configure --prefix='' \
	--disable-shared \
	--enable-static
	make V=1 $(PM)
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean compile-stage2
