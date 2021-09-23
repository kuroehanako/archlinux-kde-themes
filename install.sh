#!/bin/sh

set -e

gh_repo="archlinux-kde-themes"
gh_desc="Archlinux with KDE"

cat <<- EOF

  Welcome!

  $gh_desc
  https://github.com/kuroehanako/$gh_repo

EOF

: "${PREFIX:=/usr}"
: "${TAG:=main}"
: "${uninstall:=false}"

_msg() {
    echo "=>" "$@" >&2
}

_rm() {
    # removes parent directories if empty
    sudo rm -rf "$1"
    sudo rmdir -p "$(dirname "$1")" 2>/dev/null || true
}

_download() {
    _msg "Getting the latest version from GitHub ..."
    wget -O "$temp_file" \
        "https://github.com/kuroehanako/$gh_repo/archive/$TAG.tar.gz"
    _msg "Unpacking archive ..."
    tar -xzf "$temp_file" -C "$temp_dir"
}

_uninstall() {
    _msg "Deleting..."
    _rm "$PREFIX/share/plasma/desktoptheme/archlinux"
	_rm "$PREFIX/share/plasma/desktoptheme/archlinux-dark"
	_rm "$PREFIX/share/plasma/look-and-feel/org.archlinux.kdedark.desktop"
	_rm "$PREFIX/share/plasma/look-and-feel/org.archlinux.kdedefault.desktop"
	_rm "$PREFIX/share/plasma/look-and-feel/org.archlinux.kdelight.desktop"
	_rm "$PREFIX/share/wallpapers/archbtw"
	_rm "$PREFIX/share/wallpapers/archwave"
	_rm "$PREFIX/share/wallpapers/archwaveinv"
	_rm "$PREFIX/share/wallpapers/awesome"
	_rm "$PREFIX/share/wallpapers/conference"
	_rm "$PREFIX/share/wallpapers/geolanes"
	_rm "$PREFIX/share/wallpapers/geowaves"
	_rm "$PREFIX/share/wallpapers/gritty"
	_rm "$PREFIX/share/wallpapers/landscape"
	_rm "$PREFIX/share/wallpapers/lone"
	_rm "$PREFIX/share/wallpapers/mountain"
	_rm "$PREFIX/share/wallpapers/reflected"
	_rm "$PREFIX/share/wallpapers/simple"
	_rm "$PREFIX/share/wallpapers/small"
	_rm "$PREFIX/share/wallpapers/snow"
	_rm "$PREFIX/share/wallpapers/split"
	_rm "$PREFIX/share/wallpapers/sunset"
	_rm "$PREFIX/share/wallpapers/svalbard"
	_rm "$PREFIX/share/wallpapers/wave"
	_rm "$PREFIX/share/wallpapers/wild"
	_rm "$PREFIX/share/wallpapers/wirefeather"
	_rm "$PREFIX/share/wallpapers/wireparts"
}

_install() {
    _msg "Installing ..."
    sudo cp -R \
        "$temp_dir/$gh_repo-$TAG/plasma" \
        "$temp_dir/$gh_repo-$TAG/wallpapers" \
        "$PREFIX/share"
}

temp_file="$(mktemp -u)"
temp_dir="$(mktemp -d)"

if [ "$uninstall" = "false" ]; then
    _uninstall
    _install
else
    _uninstall
fi
