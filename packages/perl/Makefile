# Perl Makefile

NM= perl
VRS= 5.16.1
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://www.cpan.org/src/5.0/$(FILE)
SHA256-$(FILE)= 759a2479587024fa64685e04dbfb4ef07461aef3aff932a34d0c1435d4fa1d97

include $(MY_ROOT)/scripts/functions.mk

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
	make $(PM)
	make install
	cd ext/POSIX; perl Makefile.PL
	cd ext/POSIX; make
	cd ext/POSIX; make install

clean:
	-rm -rf $(DIR)

.PHONY: clean compile-stage2
