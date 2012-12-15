# pkg-config Makefile

NM= pkg-config
VRS= 0.25
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://pkgconfig.freedesktop.org/releases/$(FILE)
SHA256-$(FILE)= 3ba691ee2431f32ccb8efa131e59bf23e37f122dc66791309023ca6dcefcd10e

include $(MY_ROOT)/scripts/functions.mk

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	$(musl_prep)
	./configure \
          --prefix='' \
	  --with-pc-path=/lib/pkgconfig
	make $(PM)
	make install
