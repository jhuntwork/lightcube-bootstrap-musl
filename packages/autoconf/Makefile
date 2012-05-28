# autoconf Makefile

NM= autoconf
VRS= 2.69
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.xz
URL-$(FILE)= http://ftp.gnu.org/gnu/$(NM)/$(FILE)
SHA256-$(FILE)= 64ebcec9f8ac5b2487125a86a7760d2591ac9e1d3dbd59489633f9de62a57684

include $(MY_ROOT)/scripts/functions.mk

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	$(musl_prep)
	./configure \
	--prefix=/
	make $(PM)
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean compile-stage2
