# distribute Makefile

NM= distribute
VRS= 0.6.27
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://pypi.python.org/packages/source/d/$(NM)/$(FILE)
MD5-$(FILE)= ecd75ea629fee6d59d26f88c39b2d291

include $(MY_ROOT)/scripts/functions.mk

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	python setup.py build
	python setup.py install

clean:
	-rm -rf $(DIR)

.PHONY: clean compile-stage2
