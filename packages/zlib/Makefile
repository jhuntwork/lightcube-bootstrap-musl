# Zlib Makefile

NM= zlib
VRS= 1.2.8
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://zlib.net/$(FILE)
SHA256-$(FILE)= 36658cb768a54c1d4dec43c3116c27ed893e88b02ecfcb44f2166f9c0b7f2a0d

include $(MY_ROOT)/scripts/functions.mk

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	# Busybox doesn't support mktemp -u
	sed -i 's@mktemp -u@mktemp@' Makefile.in
	./configure --prefix=''
	make $(PM)
	make install
