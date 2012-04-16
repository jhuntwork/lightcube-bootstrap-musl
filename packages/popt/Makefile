# popt Makefile

NM= popt
VRS= 1.16
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://rpm5.org/files/$(NM)/$(FILE)
MD5-$(FILE)= 3743beefa3dd6247a73f8f7a32c14c33

include $(MY_ROOT)/scripts/functions.mk

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	$(musl_prep)
	./configure --prefix='' \
	--enable-static \
	--disable-shared
	make $(PM)
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean compile-stage2
