# This file is part of MXE.
# See index.html for further information.

PKG             := pugixml
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.6
$(PKG)_CHECKSUM := 0c22fc238b209c9fd1802b74927f0b1e9f68011c
$(PKG)_SUBDIR   := pugixml-$($(PKG)_VERSION)
$(PKG)_FILE     := pugixml-$($(PKG)_VERSION).tar.gz
$(PKG)_URL      := https://github.com/zeux/pugixml/releases/download/v$($(PKG)_VERSION)/$($(PKG)_FILE)
$(PKG)_DEPS     := gcc

define $(PKG)_BUILD
	mkdir '$(1).build'
	cd 	  '$(1).build' && CFLAGS=-O2 cmake '$(1)/scripts' \
		-DCMAKE_TOOLCHAIN_FILE='$(CMAKE_TOOLCHAIN_FILE)' \
		-DCMAKE_INSTALL_PREFIX='$(PREFIX)/$(TARGET)' \
		-DBUILD_SHARED_LIBS=ON
	$(MAKE) -C '$(1).build' -j '$(JOBS)' install
endef
