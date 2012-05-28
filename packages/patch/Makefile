# Patch Makefile

NM= patch
VRS= 2.6.1
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.xz
URL-$(FILE)= http://ftp.gnu.org/gnu/$(NM)/$(FILE)
SHA256-$(FILE)= f8da42cd777e49c4c29092d8595b36daf24cd93a38dca97f3489f1a4fb1301a0

include $(MY_ROOT)/scripts/functions.mk

stage1: $(FILE)
	$(std_build)

compile-stage1:
	$(musl_prep)
	./configure --prefix=$(TT)
	make $(PM)
	make install

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	$(musl_prep)
	./configure --prefix=''
	make $(PM)
	make install

clean:
	-rm -rf $(DIR)

.PHONY: compile-stage1 clean compile-stage2
