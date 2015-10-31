# This file is part of MXE.
# See index.html for further information.

PKG             := gst-plugins-bad
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.4.5
$(PKG)_CHECKSUM := 81ae4e15bcce8d353b83c1d2559441925794c42e
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).tar.xz
$(PKG)_URL      := http://gstreamer.freedesktop.org/src/$(PKG)/$($(PKG)_FILE)
$(PKG)_DEPS     := gcc glib gstreamer gst-plugins-base

$(PKG)_UPDATE = $(subst gstreamer/refs,gst-plugins-bad/refs,$(gstreamer_UPDATE))

define $(PKG)_BUILD
    find '$(1)' -name Makefile.in \
        -exec $(SED) -i 's,glib-mkenums,$(PREFIX)/$(TARGET)/bin/glib-mkenums,g'       {} \; \
        -exec $(SED) -i 's,glib-genmarshal,$(PREFIX)/$(TARGET)/bin/glib-genmarshal,g' {} \;
    # The value for WAVE_FORMAT_DOLBY_AC3_SPDIF comes from vlc and mplayer:
    #   http://www.videolan.org/developers/vlc/doc/doxygen/html/vlc__codecs_8h-source.html
    #   http://lists.mplayerhq.hu/pipermail/mplayer-cvslog/2004-August/019283.html
    cd '$(1)' && ./configure \
		$(MXE_CONFIGURE_OPTS) \
		--enable-opengl \
		--enable-gl \
        --disable-debug \
        --disable-examples \
        --disable-aalib \
        --disable-x \
        --disable-x11 \
        --mandir='$(1)/sink' \
        --docdir='$(1)/sink' \
        --with-html-dir='$(1)/sink'
    $(MAKE) -C '$(1)' -j '$(JOBS)' install
endef
