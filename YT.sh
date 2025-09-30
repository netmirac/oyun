#!/usr/bin/env bash

URL="https://youtube.com/shorts/4daoTdtf0z4?si=rgQYyQUuY0tivsVB"

sleep 300

if command -v google-chrome >/dev/null 2>&1; then
  google-chrome --new-window "$URL" &
elif command -v chromium >/dev/null 2>&1; then
  chromium --new-window "$URL" &
elif command -v firefox >/dev/null 2>&1; then
  firefox --new-window "$URL" &
else
  xdg-open "$URL" &
fi

sleep 5

if command -v xdotool >/dev/null 2>&1; then
  WID=$(xdotool search --onlyvisible --name "YouTube" | tail -n1)
  if [ -n "$WID" ]; then
    xdotool windowactivate "$WID"
    xdotool key --window "$WID" F11
  fi
elif command -v wmctrl >/dev/null 2>&1; then
  wid=$(wmctrl -l | grep -i "youtube" | awk '{print $1}' | tail -n1)
  [ -n "$wid" ] && wmctrl -i -r "$wid" -b add,fullscreen
fi

if command -v pactl >/dev/null 2>&1; then
  pactl set-sink-mute @DEFAULT_SINK@ 0
  pactl set-sink-volume @DEFAULT_SINK@ 100%
elif command -v amixer >/dev/null 2>&1; then
  amixer -D default set Master unmute
  amixer -D default set Master 100%
fi