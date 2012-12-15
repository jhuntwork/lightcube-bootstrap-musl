# pyalpm Makefile

NM= pyalpm
VRS= 0.5.2
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://projects.archlinux.org/users/remy/pyalpm.git/snapshot/$(FILE)
SHA256-$(FILE)= 6c9cee38579ff9f5ff6da883511f22af307fec161179de273ee924a9090a70f4

include $(MY_ROOT)/scripts/functions.mk

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	python setup.py build
	python setup.py install
