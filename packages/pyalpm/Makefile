# pyalpm Makefile

NM= pyalpm
VRS= 0.5.2
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://projects.archlinux.org/users/remy/pyalpm.git/snapshot/$(FILE)
MD5-$(FILE)= 8004236b63c7fdc6c8fa5d99a071a8b3

include $(MY_ROOT)/scripts/functions.mk

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	python setup.py build
	python setup.py install

clean:
	-rm -rf $(DIR)

.PHONY: clean compile-stage2
