# This file is part of MXE.
# See index.html for further information.

PKG             := libconfig
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.5
$(PKG)_CHECKSUM := 24306c7efce07669a4053d0977a45e2f3a3add79
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).tar.gz
$(PKG)_URL      := http://www.hyperrealm.com/libconfig/$($(PKG)_FILE)
$(PKG)_DEPS     := gcc

define $(PKG)_BUILD
    cd '$(1)' && autoreconf -fi
    cd '$(1)' && ./configure \
		$(MXE_CONFIGURE_OPTS) \
		--disable-examples
    $(MAKE) -C '$(1)' -j '$(JOBS)' install $(MXE_DISABLE_CRUFT)
endef
