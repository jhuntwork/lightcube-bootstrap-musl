# busybox Makefile

NM= busybox
VRS= 1.19.4
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://busybox.net/downloads/$(FILE)
MD5-$(FILE)= 9c0cae5a0379228e7b55e5b29528df8e

include $(MY_ROOT)/scripts/functions.mk

stage1: $(FILE)
	$(std_build)

compile-stage1:
	sed '/CONFIG_PREFIX/s@=.*@="$(TT)"@' ../busybox-config >.config
	make V=1 HOSTCC="gcc -D_GNU_SOURCE" $(PM)
	make V=1 HOSTCC="gcc -D_GNU_SOURCE" install
	chmod u+s $(TT)/bin/busybox

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	sed '/CONFIG_PREFIX/s@=.*@="/"@' ../busybox-config >.config
	make V=1 HOSTCC="gcc -D_GNU_SOURCE" $(PM)
	make V=1 HOSTCC="gcc -D_GNU_SOURCE" install
	chmod u+s /bin/busybox

clean:
	-rm -rf $(DIR)

.PHONY: compile-stage1 clean compile-stage2
