
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
	_rm "$PREFIX/share/plasma/desktoptheme/archlinux
	_rm "$PREFIX/share/plasma/desktoptheme/archlinux-dark
	_rm "$PREFIX/share/plasma/look-and-feel/org.archlinux.kdedark.desktop
	_rm "$PREFIX/share/plasma/look-and-feel/org.archlinux.kdedefault.desktop
	_rm "$PREFIX/share/plasma/look-and-feel/org.archlinux.kdelight.desktop
	_rm "$PREFIX/share/wallpapers/archbtw
	_rm "$PREFIX/share/wallpapers/archwave
	_rm "$PREFIX/share/wallpapers/archwaveinv
	_rm "$PREFIX/share/wallpapers/awesome
	_rm "$PREFIX/share/wallpapers/conference
	_rm "$PREFIX/share/wallpapers/geolanes
	_rm "$PREFIX/share/wallpapers/geowaves
	_rm "$PREFIX/share/wallpapers/gritty
	_rm "$PREFIX/share/wallpapers/landscape
	_rm "$PREFIX/share/wallpapers/lone
	_rm "$PREFIX/share/wallpapers/mountain
	_rm "$PREFIX/share/wallpapers/reflected
	_rm "$PREFIX/share/wallpapers/simple
	_rm "$PREFIX/share/wallpapers/small
	_rm "$PREFIX/share/wallpapers/snow
	_rm "$PREFIX/share/wallpapers/split
	_rm "$PREFIX/share/wallpapers/sunset
	_rm "$PREFIX/share/wallpapers/svalbard
	_rm "$PREFIX/share/wallpapers/wave
	_rm "$PREFIX/share/wallpapers/wild
	_rm "$PREFIX/share/wallpapers/wirefeather
	_rm "$PREFIX/share/wallpapers/wireparts

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
