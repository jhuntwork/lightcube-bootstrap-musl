# Patch Makefile

NM= patch
VRS= 2.6.1
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
MD5-$(FILE)= 0818d1763ae0c4281bcdc63cdac0b2c0

include $(MY_ROOT)/scripts/functions.mk

stage1: $(FILE)
	$(std_build)

compile-stage1:
	sed -i 's/linux-gnu/linux-musl/g' `find . -name config.guess -o -name config.sub`
	./configure --prefix=$(TT)
	make $(PM)
	make install

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	sed -i 's/linux-gnu/linux-musl/g' `find . -name config.guess -o -name config.sub`
	./configure --prefix=''
	make $(PM)
	make install

clean:
	-rm -rf $(DIR)

.PHONY: compile-stage1 clean compile-stage2
