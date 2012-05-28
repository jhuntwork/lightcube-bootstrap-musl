# namcap Makefile

NM= namcap
VRS= 3.2.4
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://projects.archlinux.org/namcap.git/snapshot/$(FILE)
MD5-$(FILE)= 808eba48518bff8f30d480290da90c83

include $(MY_ROOT)/scripts/functions.mk

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	sed -i 's@/usr@@g' setup.py namcap
	sed -i -e 's@--tmpdir@-t@' -e 's@XXXXXXXXXX@XXXXXX@' namcap
	python setup.py build
	python setup.py install

clean:
	-rm -rf $(DIR)

.PHONY: clean compile-stage2
