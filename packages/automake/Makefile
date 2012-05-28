# automake Makefile

NM= automake
VRS= 1.12
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.xz
URL-$(FILE)= http://ftp.gnu.org/gnu/$(NM)/$(FILE)
SHA256-$(FILE)= 4f920cad2dc59f1be296b7d7584e3828a36154d16191f3cad60a73e6e9bcf879

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
