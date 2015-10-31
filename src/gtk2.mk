# This file is part of MXE.
# See index.html for further information.

PKG             := gtk2
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 2.24.28
$(PKG)_CHECKSUM := b2c6441e98bc5232e5f9bba6965075dcf580a8726398f7374d39f90b88ed4656
$(PKG)_SUBDIR   := gtk+-$($(PKG)_VERSION)
$(PKG)_FILE     := gtk+-$($(PKG)_VERSION).tar.xz
$(PKG)_URL      := http://ftp.gnome.org/pub/gnome/sources/gtk+/$(call SHORT_PKG_VERSION,$(PKG))/$($(PKG)_FILE)
$(PKG)_DEPS     := gcc atk cairo gdk-pixbuf gettext glib jasper jpeg libpng pango tiff

define $(PKG)_UPDATE
    $(WGET) -q -O- 'http://git.gnome.org/browse/gtk+/refs/tags' | \
    grep '<a href=' | \
    $(SED) -n 's,.*<a[^>]*>\([0-9]*\.[0-9]*[02468]\.[^<]*\)<.*,\1,p' | \
    grep -v '^2\.9' | \
    grep '^2\.' | \
    head -1
endef

define $(PKG)_BUILD
    cd '$(1)' && rm gtk/gtk.def && ./configure \
        $(MXE_CONFIGURE_OPTS) \
        --enable-explicit-deps \
        --disable-glibtest \
        --disable-modules \
        --disable-cups \
		--disable-debug \
        --disable-test-print-backend \
        --disable-gtk-doc \
        --disable-man \
        --with-included-immodules \
		--with-gdktarget=win32 \
        --without-x
    $(MAKE) -C '$(1)' -j '$(JOBS)' install bin_PROGRAMS= sbin_PROGRAMS= noinst_PROGRAMS=

    '$(TARGET)-gcc' \
        -W -Wall -Werror -ansi \
        '$(2).c' -o '$(PREFIX)/$(TARGET)/bin/test-gtk2.exe' \
        `'$(TARGET)-pkg-config' gtk+-2.0 gmodule-2.0 --cflags --libs`
endef
