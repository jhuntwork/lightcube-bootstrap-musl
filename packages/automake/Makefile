NM= automake
VRS= 1.12.5
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.xz
URL-$(FILE)= http://ftp.gnu.org/gnu/$(NM)/$(FILE)
SHA256-$(FILE)= 35dac82775f100de4699818cf62dda341cd6020189e5345ab1461859f35097cc

include $(MY_ROOT)/scripts/functions.mk

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	$(musl_prep)
	./configure --prefix=''
	make V=1 $(PM)
	make install
