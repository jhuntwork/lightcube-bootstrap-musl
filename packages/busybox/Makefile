# busybox Makefile

NM= busybox
VRS= 1.19.4
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://busybox.net/downloads/$(FILE)
SHA256-$(FILE)= 9b853406da61ffb59eb488495fe99cbb7fb3dd29a31307fcfa9cf070543710ee

include $(MY_ROOT)/scripts/functions.mk

stage1: $(FILE)
	$(std_build)

compile-stage1:
	sed '/CONFIG_PREFIX/s@=.*@="$(TT)"@' ../busybox-config >.config
	sed -i '/netinet\/ether/d' networking/arp.c
	sed -i '/net\/if_slip/d' networking/ifconfig.c
	sed -i '/net\/if_packet/d' networking/libiproute/iplink.c
	sed -i '/getpwent/s@!.*@(pwent = getpwent()) != NULL) {@' loginutils/deluser.c
	sed -i -e '/struct passwd \*pw/d' \
          -e 's@struct passwd pwent@struct passwd \*pwent@' \
          -e 's@pwent\.pw@pwent->pw@g' loginutils/deluser.c
	sed -i -e '/WGET/s@^# @@' -e '/WGET/s@ is not set@=y@' .config
	make V=1 HOSTCC="gcc -D_GNU_SOURCE" $(PM)
	make V=1 HOSTCC="gcc -D_GNU_SOURCE" install
	chmod u+s $(TT)/bin/busybox

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	sed '/CONFIG_PREFIX/s@=.*@="/"@' ../busybox-config >.config
	sed -i '/netinet\/ether/d' networking/arp.c
	sed -i '/net\/if_slip/d' networking/ifconfig.c
	sed -i '/net\/if_packet/d' networking/libiproute/iplink.c
	sed -i '/getpwent/s@!.*@(pwent = getpwent()) != NULL) {@' loginutils/deluser.c
	sed -i -e '/struct passwd \*pw/d' \
          -e 's@struct passwd pwent@struct passwd \*pwent@' \
          -e 's@pwent\.pw@pwent->pw@g' loginutils/deluser.c
	make V=1 HOSTCC="gcc -D_GNU_SOURCE" $(PM)
	make V=1 HOSTCC="gcc -D_GNU_SOURCE" install
	chmod u+s /bin/busybox

clean:
	-rm -rf $(DIR)

.PHONY: compile-stage1 clean compile-stage2
