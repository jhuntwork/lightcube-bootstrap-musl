# Build Order
STAGE0= binutils gcc linux-headers
STAGE1= musl binutils gcc busybox patch make
STAGE2= linux-headers musl zlib binutils gcc file ncurses busybox readline \
bash make patch perl openssl curl libarchive pkg-config m4 autoconf automake \
pacman
# NOTE: m4, autoconf and automake can be removed when upgrading
# to a released version of pacman
# The following are additional packages for extending functionality in pacman:
# python libelf pyalpm pyelftools distribute namcap

# Location for the temporary tools, must be a directory immediately under /
export TT := /tools

# Location for the sources, must be a directory immediately under /
export SRC := /sources

# The name of the build user account to create and use for the temporary tools
export USER := lcbuilduser

# Compiler optimizations
export CFLAGS := -D_GNU_SOURCE -O2 -pipe -fomit-frame-pointer -fno-asynchronous-unwind-tables
export PM := -j$(shell grep processor /proc/cpuinfo | wc -l)
#export PM := -j1

# Set the base architecture
export MY_ARCH := $(shell uname -m)

# The full path to the build scripts on the host OS
# e.g., /mnt/build/build-env
export MY_BASE := $(shell pwd)

# The path to the build directory - This must be the parent directory of $(MY_BASE)
# e.g., /mnt/build
export MY_BUILD := $(shell dirname $(MY_BASE))

# The chroot form of $(MY_BASE), needed so that certain functions and scripts will
# work both inside and outside of the chroot environment.
# e.g., /build-env
export MY_ROOT := /$(shell basename $(MY_BASE))

# Environment Variables
ifeq ($(shell su --help 2>&1 | grep -q "session\-command"; echo $$?),0)
export SUCMD := su --session-command
else
export SUCMD := su -c
endif

export toolsenv := env -i LC_ALL=POSIX HOME=/home/$(USER) PATH=$(TT)/bin:/bin:/usr/bin /bin/sh -c
export chenv := env -i LC_ALL=POSIX HOME=/root PATH=/bin:/sbin:$(TT)/bin sh -c

# Architecture specifics
ifeq ($(MY_ARCH),i686)
endif

ifeq ($(MY_ARCH),x86_64)
export ARCH64 := true
export MY_32BIT = i686-unknown-linux-musl
endif

export BUILD_ARCH := $(MY_ARCH)-custom-linux-musl
export BUILD_TRUE := $(MY_ARCH)-unknown-linux-musl

export pg := .progress

all: test-host $(pg) $(pg)/base package
	@echo "All tasks completed successfully!"

# Check host prerequisites
# FIXME: Fill this out with more package pre-reqs
test-host:
	@if [ "`whoami`" != "root" ] ; then \
	 echo "You must be logged in as root." && exit 1 ; fi

$(pg):
	install -d $(pg)

# Build the base system
$(pg)/base: $(pg)/dirstruct $(pg)/builduser build
	@touch $@

build: $(pg)/build-tools
	@make mount
	@chroot "$(MY_BUILD)" $(chenv) 'chown -R 0:0 $(SRC) $(MY_ROOT) && \
	 cd $(MY_ROOT) && make buildchroot'

# Create the core directory structure
$(pg)/dirstruct:
	install -d $(MY_BASE)/logs $(MY_BUILD)$(SRC) $(MY_BUILD)$(TT)/bin
	-ln -nsf $(MY_BUILD)$(TT) /
	-ln -nsf $(MY_BUILD)$(SRC) /
	-ln -nsf $(MY_BASE) /
	install -m755 $(MY_ROOT)/scripts/unpack $(TT)/bin
	install -m755 $(MY_ROOT)/scripts/teelog $(TT)/bin
	install -d $(MY_BUILD)/bin $(MY_BUILD)/etc $(MY_BUILD)/lib $(MY_BUILD)/include $(MY_BUILD)/sbin $(MY_BUILD)/var
	install -d -m 0750 $(MY_BUILD)/root
	install -d -m 1777 $(MY_BUILD)/tmp $(MY_BUILD)/var/tmp
	install -d $(MY_BUILD)/var/lock $(MY_BUILD)/var/log $(MY_BUILD)/var/run $(MY_BUILD)/var/spool
	cp $(MY_ROOT)/etc/passwd $(MY_BUILD)/etc
	cp $(MY_ROOT)/etc/group $(MY_BUILD)/etc
	echo "127.0.0.1 localhost $(shell hostname)" >$(MY_BUILD)/etc/hosts
	@touch $@

# Add the unprivileged user - will be used for building the temporary tools
$(pg)/builduser:
	@-groupadd $(USER)
	@-useradd -s /bin/sh -g $(USER) -m -k /dev/null $(USER)
	@-chown -R $(USER):$(USER) $(MY_BUILD)$(TT) $(MY_BUILD)$(SRC) $(MY_BASE)
	@touch $@

$(pg)/build-tools:
	@$(SUCMD) $(USER) -c "$(toolsenv) 'umask 022 && cd $(MY_ROOT) && make tools'"
	@install -dv $(TT)/etc
	@cp /etc/resolv.conf $(TT)/etc
	@rm -rf $(TT)/share/man $(TT)/share/info $(TT)/info $(TT)/man    
	@-ln -s $(TT)/bin/sh $(MY_BUILD)/bin/sh
	@-ln -s $(TT)/bin/bash $(MY_BUILD)/bin/bash
	@-ln -s $(TT)/bin/env $(MY_BUILD)/bin/env
	@chown 0:0 $(TT)/bin/busybox
	@chmod u+s $(TT)/bin/busybox
	@touch $@

tools:
	@for pkg in $(STAGE0) ; do make packages/$${pkg}/stage0 || exit; done
	@for pkg in $(STAGE1) ; do make packages/$${pkg}/stage1 || exit; done

mount: $(pg)/mount

$(pg)/mount: unmount $(pg)/prep-mount
	@mount -t proc proc $(MY_BUILD)/proc
	@mount -t sysfs sysfs $(MY_BUILD)/sys
	@mount -t tmpfs shm $(MY_BUILD)/dev/shm
	@mount -t devpts devpts $(MY_BUILD)/dev/pts
	@ln -sf /proc/self/fd/0 $(MY_BUILD)/dev/stdin
	@ln -sf /proc/self/fd/1 $(MY_BUILD)/dev/stdout
	@ln -sf /proc/self/fd/2 $(MY_BUILD)/dev/stderr
	@touch $@

$(pg)/prep-mount:
	install -d $(MY_BUILD)/proc $(MY_BUILD)/sys $(MY_BUILD)/dev
	-mknod -m 600 $(MY_BUILD)/dev/console c 5 1
	-mknod -m 666 $(MY_BUILD)/dev/null c 1 3
	-mknod -m 660 $(MY_BUILD)/dev/zero c 1 5
	-mknod -m 444 $(MY_BUILD)/dev/random c 1 8
	-mknod -m 444 $(MY_BUILD)/dev/urandom c 1 9
	install -d $(MY_BUILD)/dev/pts $(MY_BUILD)/dev/shm
	@touch $@

buildchroot: $(pg)/createfiles
	@for pkg in $(STAGE2) ; do make packages/$${pkg}/stage2 || exit; done

$(pg)/createfiles:
	-for dir in /bin /etc /lib ; do install -dv $$dir ; done
	@-$(TT)/bin/ln -s $(TT)/bin/sh /bin
	@-$(TT)/bin/ln -s $(TT)/bin/cat /bin
	@-$(TT)/bin/ln -s $(TT)/bin/pwd /bin
	@-$(TT)/bin/ln -s $(TT)/bin/stty /bin
	@cp $(TT)/etc/resolv.conf /etc
	@ln -s /proc/mounts /etc/mtab
	@touch $@

package: unmount
	@echo "Packaging build environment..."
	@cd $(MY_BUILD) && \
	 tar -cjf $(MY_BASE)/buildenv-$(shell date +%Y%m%d%H%M).tar.bz2 \
	  --exclude=$(shell basename $(MY_BASE)) \
	  --exclude=$(shell basename $(SRC)) \
	  --exclude=$(shell basename $(TT)) \
	  --exclude=lost+found * 

unmount:
	@-umount $(MY_BUILD)/dev/shm
	@-umount $(MY_BUILD)/dev/pts
	@-umount $(MY_BUILD)/proc
	@-umount $(MY_BUILD)/sys
	@-rm -f $(MY_BASE)/mount

packages/stop/%:
	@echo Stopping due to user specified stop point.
	@exit 1

%clean:
	make -C packages/$* clean

%stage0:
	make -C $* clean
	hash -r && make -C $* stage0
%stage1:
	make -C $* clean
	hash -r && make -C $* stage1
%stage2:
	make -C $* clean
	hash -r && make -C $* stage2

clean: unmount
	@-userdel -r $(USER)
	@-groupdel $(USER)
	@rm -f $(pg)/*
	@-for pkg in $(STAGE1); do make -C packages/$${pkg} clean ; done
	@-for pkg in $(STAGE2); do make -C packages/$${pkg} clean ; done
	@find packages -name "stage*" -exec rm -f \{} \;
	@find packages -name "*.log" -exec rm -f \{} \;
	@find packages -type l -exec rm -f \{} \;
	@rm -rf $(MY_BUILD)$(TT) $(MY_BASE)/log*
	@rm -f $(TT) $(SRC) $(MY_ROOT)

scrub: clean
	@for i in `find $(MY_BUILD) -mindepth 1 -maxdepth 1`; \
	 do \
	  case "$$i" in \
		$(MY_BASE)|$(MY_BUILD)$(SRC)) echo Keeping "$$i" ;; \
		*) echo Removing "$$i" ; rm -rf "$$i" ;; \
	  esac ; \
	 done

.PHONY: unmount clean buildchroot tools
