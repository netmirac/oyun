#!/usr/bin/env bash
# persistent popup for Pardus/Debian (uses zenity if available)
TITLE="HACKLENDİNİZ"
MESSAGE="Sistem uyarısı. Lütfen dikkate alınız."
WIDTH=600
HEIGHT=200
REPEAT_DELAY=0.7   # pencere kapatıldıktan sonra yeniden açılana kadar saniye

trap 'echo "İptal sinyali alındı. Script durduruluyor."; exit 0' SIGINT SIGTERM

if command -v zenity >/dev/null 2>&1; then
  while true; do
    # --warning gösterir; kullanıcı kapatsa dahi döngü devam eder ve kısa süre sonra tekrar açılır
    zenity --warning --title="$TITLE" --no-wrap --text="$MESSAGE" --width="$WIDTH" --height="$HEIGHT"
    sleep "$REPEAT_DELAY"
  done
else
  # zenity yoksa basit fallback: notify-send + terminal prompt (kullanıcı kapatılsa yeniden açılmaz ama çalışır)
  if command -v notify-send >/dev/null 2>&1; then
    while true; do
      notify-send "$TITLE" "$MESSAGE"
      sleep 5
    done
  else
    echo "$TITLE"
    echo
    echo "$MESSAGE"
    echo
    echo "Ne zenity ne notify-send bulunamadı. Zenity yüklemeyi düşünün."
    exit 1
  fi
fi
