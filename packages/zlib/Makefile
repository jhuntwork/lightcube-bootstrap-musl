# Zlib Makefile

NM= zlib
VRS= 1.2.7
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://zlib.net/$(FILE)
SHA256-$(FILE)= 49e2e9658dfb036900da6ea0267a737fa3c4eee6666776d378c79d52e9334934

include $(MY_ROOT)/scripts/functions.mk

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	# Busybox doesn't support mktemp -u
	sed -i 's@mktemp -u@mktemp@' Makefile.in
	./configure --prefix=''
	make $(PM)
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean compile-stage2
