#!/usr/bin/env bash

URL="https://youtube.com/shorts/4daoTdtf0z4?si=rgQYyQUuY0tivsVB"

# 5 dakika bekle
sleep 300

# Chrome'u tam ekran modda başlat
google-chrome --new-window --start-fullscreen "$URL" &
