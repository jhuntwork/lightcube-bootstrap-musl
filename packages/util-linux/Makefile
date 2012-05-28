# util-linux Makefile

NM= util-linux
VRS= 2.21.1
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.xz
URL-$(FILE)= http://www.kernel.org/pub/linux/utils/util-linux/v2.21/$(FILE)
SHA256-$(FILE)= 6ffaffb46bfb1aa403f83f0c8d2700e5ec35ffcb35a0573adb10404ed16c9004

FILE1= ttydefaults.h
PATCH= util-linux-more-regex.patch
PATCH1= util-linux-prog_invoke_name.patch

include $(MY_ROOT)/scripts/functions.mk

stage2: Makefile $(FILE)
	$(std_build)

CFLAGS += -Dversionsort=alphasort -D__GNU_LIBRARY__=5 -DMAXNAMLEN=255

compile-stage2:
	$(musl_prep)
	# Fix use of obsolete re_exec and re_comp
	patch -Np0 -i ../$(PATCH)
	# Fix use of program_invocation_short_name in hexsyntax.c
	patch -Np1 -i ../$(PATCH1)
	sed -i -e 's@etc/adjtime@var/lib/hwclock/adjtime@g' \
	  $$(grep -rl '/etc/adjtime' .)
	sed -i 's@__sighandler_t@sighandler_t@' fdisk/cfdisk.c
	sed -i "/fcntl.h/s@.*@&\n#include <strings.h>@" libmount/src/tab_parse.c
	sed -i '/ifdef HAVE_DECL__NL_TIME_WEEK_1STDAY/s@ifdef@if@' misc-utils/cal.c 
	# Remove usage of __P
	sed -i -e '/__P/s@((@(@' -e '/__P/s@))@)@' -e '/__P/s@__P@@' misc-utils/logger.c
	# Remove use of glibc specific program_invocation_short_name
	sed -i 's@program_invocation_short_name@"uuidd"@g' misc-utils/uuidd.c
	# Add ttydefaults from glibc for this application
	cp ../$(FILE1) term-utils/
	sed -i "/strutils.h/s@.*@#include \"ttydefaults.h\"\n&@" term-utils/agetty.c
	# Missing sys/types.h
	sed -i "/hexdump.h/s@.*@#include <sys/types.h>\n&@" text-utils/display.c
	# No sys/termios.h
	sed -i 's@sys/termios@termios@' text-utils/pg.c
	./configure \
          --prefix='' \
	  --disable-schedutils
	make V=1 $(PM)
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean compile-stage2
