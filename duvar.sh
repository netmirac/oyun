#!/usr/bin/env bash
set -e

URL="https://raw.githubusercontent.com/netmirac/oyun/refs/heads/main/1758170394838.jpg"
DIR="$HOME/.local/share/backgrounds"
FILE="$DIR/1758170394838.jpg"

mkdir -p "$DIR"

if command -v curl >/dev/null 2>&1; then
  curl -fsSL "$URL" -o "$FILE"
elif command -v wget >/dev/null 2>&1; then
  wget -qO "$FILE" "$URL"
else
  printf "curl veya wget bulunamadı. İndirilemiyor.\n" >&2
  exit 1
fi

if command -v gsettings >/dev/null 2>&1; then
  gsettings set org.gnome.desktop.background picture-uri "file://$FILE"
  gsettings set org.gnome.desktop.background picture-options "zoom"
  printf "Duvar kağıdı ayarlandı: %s\n" "$FILE"
else
  printf "gsettings bulunamadı. GNOME mu kullanıyorsunuz?\n" >&2
  exit 1
fi
