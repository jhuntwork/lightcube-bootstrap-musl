# strace Makefile

NM= strace
VRS= 4.6
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.xz
URL-$(FILE)= http://iweb.dl.sourceforge.net/project/$(NM)/$(NM)/$(VRS)/$(FILE)
MD5-$(FILE)= e537b2b1afeec70c0e6e27a0d0fd671e

include $(MY_ROOT)/scripts/functions.mk

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	sed -i 's@linux-gnu@linux-musl@g' `find . -name config.sub -o -name config.guess`
	sed -i '170 s@.*@& \&\& !defined(PTRACE_POKEUSER)@' defs.h
	sed -i "36 s@.*@\n#if defined(LINUX) \&\& !defined(MSG_EXCEPT)\n#define MSG_EXCEPT      020000\n#endif@" ipc.c
	sed -i 's@loff_t@off_t@g' io.c
	sed -i '114,119d' net.c
	sed -i "44 s@.*@\n#if defined(LINUX) \&\& !defined(TCP_MAXSEG)\n#define TCP_MAXSEG      2\n#endif@" net.c
	sed -i 's@__sched_priority@sched_priority@g' process.c
	sed -i -e '458 s@.*@& \&\& !defined(__musl__)@' \
	       -e 's@__sighandler_t@sighandler_t@g' signal.c
	hush -c './configure --prefix=/usr'
	hush -c 'make'
	hush -c 'make install'

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
