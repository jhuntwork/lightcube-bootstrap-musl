# Perl Makefile

NM= perl
VRS= 5.14.2
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://www.cpan.org/src/5.0/$(FILE)
MD5-$(FILE)= 3306fbaf976dcebdcd49b2ac0be00eb9

include $(MY_ROOT)/scripts/functions.mk

stage1: $(FILE)
	$(std_build)

compile-stage1:
	chmod 777 hints/linux.sh
	echo 'locincpth=""' >> hints/linux.sh
	echo 'loclibpth=""' >> hints/linux.sh
	echo 'glibpth="$(TT)/lib"' >> hints/linux.sh
	echo 'usrinc="$(TT)/include"' >> hints/linux.sh
	echo 'libc="$(TT)/lib/libc.so"' >> hints/linux.sh
	./Configure -des -Accflags='-D_GNU_SOURCE' -Dprefix=$(TT)
	make
	cp -v perl cpan/podlators/pod2man $(TT)/bin
	mkdir -p $(TT)/lib/perl5/$(VRS)
	cp -R lib/* $(TT)/lib/perl5/$(VRS)

chroot:
	chroot "$(MP)" $(chenv-pre-bash) \
	'cd $(MY_ROOT) && make ch-$(NM) $(chbash-pre-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	for file in `grep -l -r "/usr" .` ; do sed -i -e 's@/usr/local@@g' -e 's@/usr@@g' $$file ; done 
	sed -i -e "s|BUILD_ZLIB\s*= True|BUILD_ZLIB = False|"           \
	  -e "s|INCLUDE\s*= ./zlib-src|INCLUDE    = /include|" \
	  -e "s|LIB\s*= ./zlib-src|LIB        = /lib|"         \
	  cpan/Compress-Raw-Zlib/config.in
	CFLAGS="$$CFLAGS" ./configure.gnu \
	 -des -Dprefix=/ \
         -Dcc="gcc -D_GNU_SOURCE" \
	 -Dbin=/bin \
	 -Dinstallsitebin=/bin \
	 -Dvendorprefix=/ \
	 -Dprivlib=/lib/perl5/$(VRS) \
	 -Darchlib=/lib/perl5/$(VRS)/$(MY_ARCH)-linux \
	 -Dsitelib=/lib/perl5/site_perl/$(VRS) \
	 -Dvendorlib=/lib/perl5/vendor_perl/$(VRS) \
	 -Dvendorarch=/lib/perl5/vendor_perl/$(VRS)/$(MY_ARCH)-linux \
	 -Dscriptdir=/bin \
  	 -Dsitescript=/bin \
	 -Dvendorbin=/bin \
  	 -Dvendorscript=/bin \
	 -Dman1dir=/share/man/man1 \
	 -Dman3dir=/share/man/man3 \
	 -Dpager="/bin/less -isR" \
	 -Duseshrplib
	make
	make install
	cd ext/POSIX; perl Makefile.PL
	cd ext/POSIX; make
	cd ext/POSIX; make install

clean:
	-rm -rf $(DIR)

.PHONY: compile-stage1 clean chroot compile-stage2
