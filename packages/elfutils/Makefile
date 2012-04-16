# elfutils Makefile

NM= elfutils
VRS= 0.152
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
#URL-$(FILE)= https://fedorahosted.org/releases/e/l/$(NM)/$(VRS)/$(FILE)
MD5-$(FILE)= 39739ed58a0fa1862eff8735f111fe5c

PATCH1= elfutils-add_ar.h.patch

PATCH2= elfutils-portability.patch
URL-$(PATCH2)= $(HTTP)/$(NM)/$(PATCH2)
#URL-$(PATCH2)= https://fedorahosted.org/releases/e/l/$(NM)/$(VRS)/$(PATCH2)
MD5-$(PATCH2)= 80c41bb3bd8f2108f80c15f1908f3abd

include $(MY_ROOT)/scripts/functions.mk

stage2: Makefile $(FILE) $(PATCH2)
	$(std_build)

compile-stage2:
	$(musl_prep)
	patch -Np1 -i ../$(PATCH1)
	patch -Np1 -i ../$(PATCH2)
	sed -i 's@loff_t@off_t@g' libelf/libelf.h
	#add TEMP_FAILURE_RETRY macro
	sed -i "/stdint/s@.*@&\n#define TEMP_FAILURE_RETRY(x) x\n#define rawmemchr(s,c) memchr((s),(size_t)-1,(c))@" lib/system.h
	# no cdefs.h header
	sed -i '/cdefs/d' lib/fixedsizehash.h
	sed -i -e "s@__BEGIN_DECLS@#ifdef __cplusplus\nextern \"C\" {\n#endif@" \
	-e "s@__END_DECLS@#ifdef __cplusplus\n}\n#endif@" libelf/elf.h
	# use mempcpy instead of __mempcpy
	sed -i 's@__mempcpy@mempcpy@g' libelf/elf_begin.c 
	./configure --prefix='' \
	--disable-nls
	find . -name Makefile -exec sed -i 's/-Werror//g' '{}' \;
	make CFLAGS="$$CFLAGS" -C libelf libelf.a
	install -m644 libelf/libelf.a /lib/

clean:
	-rm -rf $(DIR)

.PHONY: clean compile-stage2
