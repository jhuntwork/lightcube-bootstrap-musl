# bash Makefile

NM= bash
VRS= 4.2
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://ftp.gnu.org/gnu/$(NM)/$(FILE)
MD5-$(FILE)= 3fb927c7c33022f1c327f14a81c0d4b0

include $(MY_ROOT)/scripts/functions.mk

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	$(musl_prep)
	export LDFLAGS='--static'
	./configure \
          --prefix=/ \
          --disable-nls \
          --without-bash-malloc \
          --with-installed-readline \
          ac_cv_func_mbsnrtowcs=no
	make $(PM)
	make install
	install -m 0644 ../profile /etc/
	install -m 0644 ../bashrc /etc/

clean:
	-rm -rf $(DIR)

.PHONY: clean compile-stage2
