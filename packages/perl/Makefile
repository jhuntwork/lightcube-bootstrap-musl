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
	sed -i 's@-fstack-protector@@g' Configure
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
	for file in `grep -l -r "/usr" .` ; do sed -i 's@/usr@/@g' $$file ; done 
	sed -i 's@-fstack-protector@@g' Configure
	sh Configure -des -Dprefix=/ \
	 -Dvendorprefix=/           \
	 -Dman1dir=/share/man/man1 \
	 -Dman3dir=/share/man/man3 \
	 -Dpager="/bin/less -isR"
	make OPTIMIZE="$$CFLAGS"
	make install

clean:
	-rm -rf $(DIR)

.PHONY: compile-stage1 clean chroot compile-stage2
