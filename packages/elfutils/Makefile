# elfutils Makefile

NM= elfutils
VRS= 0.152
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= https://fedorahosted.org/releases/e/l/$(NM)/$(VRS)/$(FILE)
MD5-$(FILE)= 39739ed58a0fa1862eff8735f111fe5c

PATCH1= elfutils-add_ar.h.patch

PATCH2= elfutils-portability.patch
URL-$(PATCH2)= https://fedorahosted.org/releases/e/l/$(NM)/$(VRS)/$(PATCH2)
MD5-$(PATCH2)= 80c41bb3bd8f2108f80c15f1908f3abd

# Targets

include $(MY_ROOT)/scripts/functions.mk

stage2: Makefile $(FILE) $(PATCH2) 
	$(std_build)

# The following macros are required to be placed somewhere
# glibc has them in sys/param.h
# #define MIN(a,b) (((a)<(b))?(a):(b))
# #define MAX(a,b) (((a)>(b))?(a):(b))
# #define powerof2(x) ((((x) - 1) & (x)) == 0)
# #define __CONCAT(x,y)   x ## y

compile-stage2:
	patch -Np1 -i ../$(PATCH1)
	patch -Np1 -i ../$(PATCH2)
	sed -i 's@loff_t@off_t@g' libelf/libelf.h
	sed -i "/stdint/s@.*@&\n#define TEMP_FAILURE_RETRY(x) x\n#define rawmemchr(s,c) memchr((s),(size_t)-1,(c))@" lib/system.h
	sed -i 's@linux-gnu@linux-musl@g' config/config.sub
	sed -i '/cdefs/d' lib/fixedsizehash.h
	sed -i -e \
      "s@__BEGIN_DECLS@#ifdef __cplusplus\nextern \"C\" {\n#endif@" \
      -e "s@__END_DECLS@#ifdef __cplusplus\n}\n#endif@" libelf/elf.h
	sed -i 's@__mempcpy@mempcpy@g' libelf/elf_begin.c 
	hush -c 'CC="gcc" ./configure --prefix=/usr \
    --disable-nls \
    --host=$(BUILD_TRUE) \
    --build=$(BUILD_TRUE) \
    --target=$(BUILD_TRUE) ac_cv_tls=no'
	find . -name Makefile -exec sed -i 's/-Werror//g' '{}' \;
	hush -c 'make -C libelf $(PM)'
	hush -c 'make -C libelf install'

clean:
	-rm -rf $(DIR)

.PHONY: clean compile-stage2
