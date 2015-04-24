define basic_setup
	@$(clean_build)
	@$(INFO) "Setting up log at $(MY_ROOT)/logs/$(DIR)-$@.log..."
	@>$(DIR)-$@.log
	@-ln -sf ../packages/$(shell basename $(CURDIR))/$(DIR)-$@.log $(MY_ROOT)/logs/
endef

define setup_build
	@$(basic_setup)
	@$(INFO) "Unpacking $(FILE)..."
	@(unpack $(FILE) 2>&1 ; echo $$?) | teelog $(DIR)-$@.log >>$(MY_ROOT)/logs/build.log
endef

define clean_build
	@if [ -d "$(DIR)" ] ; then $(INFO) "Cleaning $(DIR)..." ; find . -maxdepth 1 -type d -name "$(DIR)" -exec rm -rf '{}' + ; fi
	@if [ -d "$(DIR)-build" ] ; then $(INFO) "Cleaning $(DIR)-build..." ; find . -maxdepth 1 -type d -name "$(DIR)-build" -exec rm -rf '{}' + ; fi
endef

define compile
	@$(INFO) "Building $(DIR) with target $@..."
	@(make -C $(1) -f ../Makefile compile-$@ 2>&1 ; echo $$?) | teelog $(DIR)-$@.log >>$(MY_ROOT)/logs/build.log
	@$(OK) "Build successful..."
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
	@install -d $(DIR)-build
	@$(call compile, $(DIR)-build)
	@$(clean_build)
	@touch $@
endef

define sep_dir_build_noclean
	@$(setup_build)
	@install -dv $(DIR)-build
	@$(call compile, $(DIR)-build)
	@touch $@
endef

define musl_prep
	FILES=`find ../$(DIR)/ -name "confi*.guess" -o -name "confi*.sub"`
	if [ ! -z "$$FILES" ]; \
	then sed -i -e 's/linux-gnu/linux-musl/g' \
	       -e 's@LIBC=gnu@LIBC=musl@' \
		$$FILES; \
	fi
endef

# This takes the form of 'download [filename] [url] [sha256sum]'
define download
	@cd $(SRC) ; \
	if ! echo "$(3)  $(SRC)/$(1)" | sha256sum -c - >/dev/null 2>&1 ; then \
	    FILE=`basename "$(2)"` ; \
	    if [ -f "$$FILE" ] ; then \
	       wget -c -O "$$FILE" "$(2)" || (rm -f $$FILE && wget -O "$$FILE" "$(2)") ; \
            else \
               wget -O "$$FILE" "$(2)" ; \
	    fi ; \
        fi
	@if echo "$(3)  $(SRC)/$(1)" | sha256sum -c - >/dev/null 2>&1 ; then \
	    $(OK) "Passed sha256sum check on $(SRC)/$(1)" ; \
	else \
            $(ERROR) "Failed sha256sum check on $(SRC)/$(1)" ; \
	    $(INFO) "The sha256sum of $(SRC)/$(1) is: $$(sha256sum $(SRC)/$(1) | awk '{print $$1}')" ; \
            exit 1 ; \
        fi
	@ln -sf "$(SRC)/$(1)" .
endef

%.gz %.tgz %.xz %.bz2 %.zip %.patch %.diff %.rules %.ttf %.jpg %.run:
	$(call download,$@,$(URL-$@),$(SHA256-$@))

clean:
	$(call clean_build)

.PHONY: compile-stage0 compile-stage1 compile-stage2
