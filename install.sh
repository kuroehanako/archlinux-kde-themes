#!/bin/bash

SRC_DIR=$(cd $(dirname $0) && pwd)
ROOT_UID=0

# Destination directory
if [ "$UID" -eq "$ROOT_UID" ]; then
  PLASMA_DIR="/usr/share/plasma/desktoptheme"
  LOOKFEEL_DIR="/usr/share/plasma/look-and-feel"
  WALLPAPER_DIR="/usr/share/wallpapers"
else
  PLASMA_DIR="$HOME/.local/share/plasma/desktoptheme"
  LOOKFEEL_DIR="$HOME/.local/share/plasma/look-and-feel"
  WALLPAPER_DIR="$HOME/.local/share/wallpapers"
fi

THEME_NAME=Sunset

[[ ! -d ${PLASMA_DIR} ]] && mkdir -p ${PLASMA_DIR}
[[ ! -d ${LOOKFEEL_DIR} ]] && mkdir -p ${LOOKFEEL_DIR}
[[ ! -d ${WALLPAPER_DIR} ]] && mkdir -p ${WALLPAPER_DIR}

install() {
  local name=${1}

  cp -r ${SRC_DIR}/plasma/desktoptheme/*                                             ${PLASMA_DIR}
  cp -r ${SRC_DIR}/plasma/look-and-feel/*                                            ${LOOKFEEL_DIR}
  cp -r ${SRC_DIR}/wallpapers/*                                                       ${WALLPAPER_DIR}
}

echo "Installing '${THEME_NAME} kde themes'..."

install "${name:-${THEME_NAME}}"

echo "Install finished..."
