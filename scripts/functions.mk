define setup_build
	@touch $(DIR)-$@.log
	@-ln -sf ../packages/$(shell basename $(CURDIR))/$(DIR)-$@.log $(MY_ROOT)/logs/ 
	@>$(DIR)-$@.log
	@(unpack $(FILE) 2>&1 ; echo $$?) | teelog $(DIR)-$@.log
endef

define clean_build
	@(make clean 2>&1 ; echo $$?) | teelog $(DIR)-$@.log
endef

define compile
	@(make -C $(1) -f ../Makefile compile-$@ 2>&1 ; echo $$?) | teelog $(DIR)-$@.log
endef

define std_build
	@$(setup_build)
	@$(call compile, $(DIR))
	@$(clean_build)
	@touch $@
endef

define std_build_noclean
	@$(setup_build)
	@$(call compile, $(DIR))
	@touch $@
endef

define sep_dir_build
	@$(setup_build)
	@rm -rf $(NM)-build
	@install -d $(NM)-build
	@$(call compile, $(NM)-build)
	@$(clean_build)
	@touch $@
endef

define sep_dir_build_noclean
	@$(setup_build)
	@rm -rf $(NM)-build
	@install -dv $(NM)-build
	@$(call compile, $(NM)-build)
	@touch $@
endef

define musl_prep
	sed -i -e 's/linux-gnu/linux-musl/g' \
	       -e 's@LIBC=gnu@LIBC=musl@' \
               `find ../$(DIR)/ -name "confi*.guess" -o -name "confi*.sub"`
endef

# This takes the form of 'download [filename] [url] [md5sum]'
define download
	@cd $(SRC) ; \
	if ! echo "$(3)  $(SRC)/$(1)" | md5sum -c - >/dev/null 2>&1 ; then \
	    wget -c "$(2)" ; \
    fi
	@if echo "$(3)  $(SRC)/$(1)" | md5sum -c - >/dev/null 2>&1 ; then \
	    echo ---> md5sum check on "$(SRC)/$(1)": OK ; \
	else \
        echo ---> md5sum check on "$(SRC)/$(1)": FAILED ; \
	    echo      The md5sum for the downloaded file is: $$(md5sum $(SRC)/$(1) | awk '{print $$1}') ; \
        exit 1 ; \
    fi
	@ln -sf "$(SRC)/$(1)" .
endef

%.gz %.tgz %.xz %.bz2 %.zip %.patch %.diff %.rules %.ttf %.jpg %.run:
	$(call download,$@,$(URL-$@),$(MD5-$@))
