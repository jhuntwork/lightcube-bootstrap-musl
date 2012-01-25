define echo_message
    @echo
    @echo "--------------------------------------------------------"
	@echo "---> $(1) $(NM)-$(VRS) for target $@"
    @echo "--------------------------------------------------------"
endef

define setup_build
	@touch $(DIR)-$@.log
	@-ln -sf ../packages/$(shell basename $(CURDIR))/$(DIR)-$@.log $(MY_ROOT)/logs/ 
	@(unpack $(FILE) 2>&1 ; echo $$?) | teelog $(MY_ROOT)/logs/build.log >$(DIR)-$@.log
endef

define clean_build
	@(make clean 2>&1 ; echo $$?) | teelog $(MY_ROOT)/logs/build.log >>$(DIR)-$@.log
endef

define std_build
	@$(call echo_message, Building)
	@$(setup_build)
	@(make -C $(DIR) -f ../Makefile compile-$@ 2>&1 ; echo $$?) | teelog $(MY_ROOT)/logs/build.log >>$(DIR)-$@.log
	@$(clean_build)
	@touch $@
endef

define std_build_noclean
	@$(call echo_message, Building)
	@$(setup_build)
	@(make -C $(DIR) -f ../Makefile compile-$@ 2>&1 ; echo $$?) | teelog $(MY_ROOT)/logs/build.log >>$(DIR)-$@.log
	@touch $@
endef

define sep_dir_build
	@$(call echo_message, Building)
	@$(setup_build)
	@rm -rf $(NM)-build
	@install -d $(NM)-build
	@(make -C $(NM)-build -f ../Makefile compile-$@ 2>&1 ; echo $$?) | teelog $(MY_ROOT)/logs/build.log >>$(DIR)-$@.log
	@$(clean_build)
	@touch $@
endef

define sep_dir_build_noclean
	@$(call echo_message, Building)
	@$(setup_build)
	@rm -rf $(NM)-build
	@install -dv $(NM)-build
	@(make -C $(NM)-build -f ../Makefile compile-$@ 2>&1 ; echo $$?) | teelog $(MY_ROOT)/logs/build.log >>$(DIR)-$@.log
	@touch $@
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
