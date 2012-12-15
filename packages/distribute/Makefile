# distribute Makefile

NM= distribute
VRS= 0.6.27
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://pypi.python.org/packages/source/d/$(NM)/$(FILE)
SHA256-$(FILE)= 5d79e472ba49e5de17318a9c59b9adf5790ba6b186c6edc1657acd9afe55de00

include $(MY_ROOT)/scripts/functions.mk

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	python setup.py build
	python setup.py install
