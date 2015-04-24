NM= libtool
VRS= 2.4.6
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.xz
URL-$(FILE)= http://ftp.gnu.org/gnu/$(NM)/$(FILE)
SHA256-$(FILE)= 7c87a8c2c8c0fc9cd5019e402bed4292462d00a718a7cd5f11218153bf28b26f

include $(MY_ROOT)/scripts/functions.mk

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	$(musl_prep)
	./configure --prefix=''
	make V=1 $(PM)
	make install
