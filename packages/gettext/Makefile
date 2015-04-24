NM= gettext
VRS= 0.19.4
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.xz
URL-$(FILE)= http://ftp.gnu.org/gnu/$(NM)/$(FILE)
SHA256-$(FILE)= 719adadb8bf3e36bac52c243a01c0add18d23506a3a40437e6f5899ceab18d20

include $(MY_ROOT)/scripts/functions.mk

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	$(musl_prep)
	./configure --prefix=''
	make V=1 $(PM)
	make install
