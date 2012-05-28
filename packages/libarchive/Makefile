# libarchive Makefile

NM= libarchive
VRS= 3.0.4
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://cloud.github.com/downloads/libarchive/libarchive/$(FILE)
SHA256-$(FILE)= d595f081bca83f8ee43a70732c2795205e1f8208e04822d33980993618fe8bcf

include $(MY_ROOT)/scripts/functions.mk

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	$(musl_prep)
	./configure --prefix=/
	make $(PM)
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean compile-stage2
