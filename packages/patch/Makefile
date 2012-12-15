# Patch Makefile

NM= patch
VRS= 2.7.1
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.xz
URL-$(FILE)= http://ftp.gnu.org/gnu/$(NM)/$(FILE)
SHA256-$(FILE)= 9124ba46db0abd873d0995c2ca880e81252676bb6c03e0a37dfc5f608a9b0ceb

include $(MY_ROOT)/scripts/functions.mk

stage1: $(FILE)
	$(std_build)

compile-stage1:
	$(musl_prep)
	./configure --prefix=$(TT)
	make V=1 $(PM)
	make install

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	$(musl_prep)
	./configure --prefix=''
	make V=1 $(PM)
	make install
