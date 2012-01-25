# Perl Makefile

NM= perl
VRS= 5.14.2
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
MD5-$(FILE)= 04a4c5d3c1f9f19d77daff8e8cd19a26

# Targets

include $(MY_ROOT)/scripts/functions.mk

stage1: $(FILE) $(PATCH)
	$(std_build)

compile-stage1:
	chmod 777 hints/linux.sh
	echo 'locincpth=""' >> hints/linux.sh
	echo 'loclibpth=""' >> hints/linux.sh
	echo 'glibpth="$(TT)/lib"' >> hints/linux.sh
	echo 'usrinc="$(TT)/include"' >> hints/linux.sh
	echo 'libc="$(TT)/lib/libc.so"' >> hints/linux.sh
	sed -i 's@-fstack-protector@@g' Configure
	./Configure -des -Accflags='-D_GNU_SOURCE' -Dprefix=$(TT)
	make $(PM)
	cp -v perl cpan/podlators/pod2man $(TT)/bin
	mkdir -p $(TT)/lib/perl5/$(VRS)
	cp -R lib/* $(TT)/lib/perl5/$(VRS)

chroot:
	chroot "$(MP)" $(chenv-pre-bash) \
	'cd $(MY_ROOT) && make ch-$(NM) $(chbash-pre-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	sed -i -e "s|BUILD_ZLIB\s*= True|BUILD_ZLIB = False|" \
	 -e "s|INCLUDE\s*= ./zlib-src|INCLUDE    = /usr/include|" \
	 -e "s|LIB\s*= ./zlib-src|LIB        = /usr/$(MY_LIBDIR)|" \
      cpan/Compress-Raw-Zlib/config.in
	hush -c 'sh Configure -des -Dprefix=/usr \
	 -Dvendorprefix=/usr           \
	 -Dman1dir=/usr/share/man/man1 \
	 -Dman3dir=/usr/share/man/man3 \
	 -Dpager="/usr/bin/less -isR"'
	hush -c 'make $(PM) OPTIMIZE="$$CFLAGS"'
	hush -c 'make install'

clean:
	-rm -rf $(DIR)

.PHONY: compile-stage1 clean chroot compile-stage2
