# busybox Makefile

NM= busybox
VRS= 1.20.2
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://busybox.net/downloads/$(FILE)
SHA256-$(FILE)= eb13ff01dae5618ead2ef6f92ba879e9e0390f9583bd545d8789d27cf39b6882

PATCH1= busybox-xz-bugfix1.patch
PATCH2= busybox-xz-bugfix2.patch
PATCH3= busybox-xz-bugfix3.patch

include $(MY_ROOT)/scripts/functions.mk

stage1: $(FILE)
	$(std_build)

compile-stage1:
	patch -Np1 -i ../$(PATCH1)
	patch -Np1 -i ../$(PATCH2)
	patch -Np1 -i ../$(PATCH3)
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
	patch -Np1 -i ../$(PATCH1)
	patch -Np1 -i ../$(PATCH2)
	patch -Np1 -i ../$(PATCH3)
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
