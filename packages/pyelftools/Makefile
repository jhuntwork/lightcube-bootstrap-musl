# pyelftools Makefile

NM= pyelftools
VRS= 0.20
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://pypi.python.org/packages/source/p/$(NM)/$(FILE)
SHA256-$(FILE)= d02e40a841a8cc38d78cdea8e497f601969e7270ebe00c7e671a3ce73f1cdf45

include $(MY_ROOT)/scripts/functions.mk

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	python setup.py build
	python setup.py install

clean:
	-rm -rf $(DIR)

.PHONY: clean compile-stage2
