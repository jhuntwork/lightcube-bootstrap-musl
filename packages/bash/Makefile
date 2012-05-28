# bash Makefile

NM= bash
VRS= 4.2
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://ftp.gnu.org/gnu/$(NM)/$(FILE)
SHA256-$(FILE)= a27a1179ec9c0830c65c6aa5d7dab60f7ce1a2a608618570f96bfa72e95ab3d8

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
