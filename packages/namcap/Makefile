# namcap Makefile

NM= namcap
VRS= 3.2.4
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://projects.archlinux.org/namcap.git/snapshot/$(FILE)
SHA256-$(FILE)= b9bc5f85b9398bc359e9b34b311234ae8eca9f04df0e83c26e2c309f79e25a8e

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
