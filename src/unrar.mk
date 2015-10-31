# This file is part of MXE.
# See index.html for further information.

PKG             := unrar
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 5.3.2
$(PKG)_CHECKSUM := 2d8712eed32367b1a404633f230f94f545c1f2ce0552f851266b00c261a786ea
$(PKG)_SUBDIR   := $(PKG)
$(PKG)_FILE     := $(PKG)src-$($(PKG)_VERSION).tar.gz
$(PKG)_URL      := http://www.rarlab.com/rar/$($(PKG)_FILE)
$(PKG)_DEPS     := gcc

define $(PKG)_BUILD
    $(MAKE) -C '$(1)' -j '$(JOBS)' install-lib CXX='$(TARGET)-g++' DESTDIR='$(PREFIX)/$(TARGET)'
	$(MAKE) -C '$(1)' clean
    $(MAKE) -C '$(1)' -j '$(JOBS)' install-unrar CXX='$(TARGET)-g++' DESTDIR='$(PREFIX)/$(TARGET)' STRIP='$(TARGET)-strip'
endef
