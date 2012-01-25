# multitail Makefile

NM= multitail
VRS= 5.2.8
DIR= $(NM)-$(VRS)
FILE= $(DIR).tgz
URL-$(FILE)= http://www.vanheusden.com/$(NM)/$(FILE)
MD5-$(FILE)= aaa3691b0ea66ef02ffefd628c7dee8b

# Targets

include $(MY_ROOT)/scripts/functions.mk

prebuild: $(FILE)
	$(std_build)

compile-prebuild:
	sed -i 's@/usr@$(TT)@g' Makefile
	make $(PM)
	install -m755 multitail /tmp/

clean:
	-rm -rf $(DIR)

.PHONY: compile-prebuild clean
