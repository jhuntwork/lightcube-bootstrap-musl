# libelf Makefile

NM= elfutils
VRS= 0.152
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
MD5-$(FILE)= 39739ed58a0fa1862eff8735f111fe5c

PATCH0= elfutils-portability.patch
PATCH1= elfutils-add_ar.h.patch

include $(MY_ROOT)/scripts/functions.mk

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	patch -Np1 -i ../$(PATCH0)
	patch -Np1 -i ../$(PATCH1)
	$(musl_prep)
	sed -i 's@loff_t@off_t@g' libelf/libelf.h
	sed -i "/stdint/s@.*@&\n#define TEMP_FAILURE_RETRY(x) x\n#define rawmemchr(s,c) memchr((s),(size_t)-1,(c))@" lib/system.h
	sed -i -e '/cdefs/d' -e "/define CONCAT/s@.*@#define CONCAT1(x,y) x##y\n#define CONCAT(x,y) CONCAT1(x,y)@" lib/fixedsizehash.h
	sed -i \
	  -e "s@__BEGIN_DECLS@#ifdef __cplusplus\nextern \"C\" {\n#endif@" \
      	  -e "s@__END_DECLS@#ifdef __cplusplus\n}\n#endif@" libelf/elf.h
	sed -i 's@__mempcpy@mempcpy@g' libelf/elf_begin.c 
	./configure --prefix='' --disable-nls
	find . -name Makefile -exec sed -i 's/-Werror//g' '{}' \;
	make -C libelf $(PM)
	make -C libelf install

clean:
	-rm -rf $(DIR)

.PHONY: clean compile-stage2
