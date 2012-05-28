# Zlib Makefile

NM= zlib
VRS= 1.2.7
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://zlib.net/$(FILE)
MD5-$(FILE)= 2ab442d169156f34c379c968f3f482dd

include $(MY_ROOT)/scripts/functions.mk

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	# Busybox doesn't support mktemp -u
	sed -i 's@mktemp -u@mktemp@' Makefile.in
	./configure --prefix=''
	make
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean compile-stage2
