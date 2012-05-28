# pyelftools Makefile

NM= pyelftools
VRS= 0.20
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://pypi.python.org/packages/source/p/$(NM)/$(FILE)
MD5-$(FILE)= 5ac7b279a01c41e5b022a1a382eb9d92

include $(MY_ROOT)/scripts/functions.mk

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	python setup.py build
	python setup.py install

clean:
	-rm -rf $(DIR)

.PHONY: clean compile-stage2
