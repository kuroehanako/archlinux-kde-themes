
# GNU make is required to run this file. To install on *BSD, run:
#   gmake PREFIX=/usr/local install

PREFIX ?= /usr
IGNORE ?=
THEMES ?= plasma wallpapers

# excludes IGNORE from THEMES list
THEMES := $(filter-out $(IGNORE), $(THEMES))

all:

install:
	mkdir -p $(DESTDIR)$(PREFIX)/share
	cp -R $(THEMES) $(DESTDIR)$(PREFIX)/share

uninstall:
	-rm -rf $(DESTDIR)$(PREFIX)/share/plasma/desktoptheme/archlinux
	-rm -rf $(DESTDIR)$(PREFIX)/share/plasma/desktoptheme/archlinux-dark
	-rm -rf $(DESTDIR)$(PREFIX)/share/plasma/look-and-feel/org.archlinux.kdedark.desktop
	-rm -rf $(DESTDIR)$(PREFIX)/share/plasma/look-and-feel/org.archlinux.kdedefault.desktop
	-rm -rf $(DESTDIR)$(PREFIX)/share/plasma/look-and-feel/org.archlinux.kdelight.desktop
	-rm -rf $(DESTDIR)$(PREFIX)/share/wallpapers/archbtw
	-rm -rf $(DESTDIR)$(PREFIX)/share/wallpapers/archwave
	-rm -rf $(DESTDIR)$(PREFIX)/share/wallpapers/archwaveinv
	-rm -rf $(DESTDIR)$(PREFIX)/share/wallpapers/awesome
	-rm -rf $(DESTDIR)$(PREFIX)/share/wallpapers/conference
	-rm -rf $(DESTDIR)$(PREFIX)/share/wallpapers/geolanes
	-rm -rf $(DESTDIR)$(PREFIX)/share/wallpapers/geowaves
	-rm -rf $(DESTDIR)$(PREFIX)/share/wallpapers/gritty
	-rm -rf $(DESTDIR)$(PREFIX)/share/wallpapers/landscape
	-rm -rf $(DESTDIR)$(PREFIX)/share/wallpapers/lone
	-rm -rf $(DESTDIR)$(PREFIX)/share/wallpapers/mountain
	-rm -rf $(DESTDIR)$(PREFIX)/share/wallpapers/reflected
	-rm -rf $(DESTDIR)$(PREFIX)/share/wallpapers/simple
	-rm -rf $(DESTDIR)$(PREFIX)/share/wallpapers/small
	-rm -rf $(DESTDIR)$(PREFIX)/share/wallpapers/snow
	-rm -rf $(DESTDIR)$(PREFIX)/share/wallpapers/split
	-rm -rf $(DESTDIR)$(PREFIX)/share/wallpapers/sunset
	-rm -rf $(DESTDIR)$(PREFIX)/share/wallpapers/svalbard
	-rm -rf $(DESTDIR)$(PREFIX)/share/wallpapers/wave
	-rm -rf $(DESTDIR)$(PREFIX)/share/wallpapers/wild
	-rm -rf $(DESTDIR)$(PREFIX)/share/wallpapers/wirefeather
	-rm -rf $(DESTDIR)$(PREFIX)/share/wallpapers/wireparts

_get_version:
	$(eval VERSION := $(shell git show -s --format=%cd --date=format:%Y%m%d HEAD))
	@echo $(VERSION)

dist: _get_version
	git archive --format=tar.gz -o $(notdir $(CURDIR))-$(VERSION).tar.gz master -- $(THEMES)

release: _get_version
	git tag -f $(VERSION)
	git push origin
	git push origin --tags

undo_release: _get_version
	-git tag -d $(VERSION)
	-git push --delete origin $(VERSION)


.PHONY: all install uninstall _get_version dist release undo_release

# .BEGIN is ignored by GNU make so we can use it as a guard
.BEGIN:
	@head -3 Makefile
	@false
