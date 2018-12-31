#!/usr/bin/env bash

# Usage
# $ ./volume up
# $ ./volume down
# $ ./volume mute

function get_volume {
    amixer get Master | grep '%' | head -n 1 | cut -d '[' -f 2 | cut -d '%' -f 1
}

function is_mute {
    amixer get Master | grep '%' | grep -oE '[^ ]+$' | grep off > /dev/null
}

function send_notification {
  volume=`get_volume`
  # Make the bar with the special character ─ (it's not dash -)
  # https://en.wikipedia.org/wiki/Box-drawing_character
  bar="┠$(seq -s "─" $((1 + $volume / 5)) | sed 's/[0-9]//g')$(seq -s " " $((21 - $volume / 5)) | sed 's/[0-9]//g')┨"

  if is_mute ; then
    #dunstify -a kogy-notif -i audio-volume-muted-blocking -r 424242 "Mute   $bar"
    dunstify -a kogy-notif -i audio-volume-muted-symbolic -r 424242 "Mute   $bar"
  else
    # Send the notification
    #dunstify -i audio-volume-muted-blocking -t 8 -r 2593 -u normal "    $bar"
    #dunstify -a kogy-notif -i audio-volume-muted-blocking -r 424242 "$(printf "%3s%%" $volume)   $bar"
    dunstify -a kogy-notif -i audio-volume-high-symbolic -r 424242 "$(printf "%3s%%" $volume)   $bar"

    # beep
    aplay $HOME/.config/i3/scripts/beep.ogg -q
  fi
}

case $1 in
    up)
      # Set the volume on (if it was muted)
      amixer -D pulse set Master on > /dev/null
      # Up the volume (+ 5%)
      amixer -D pulse sset Master 5%+ > /dev/null
      send_notification
      ;;
    down)
      amixer -D pulse set Master on > /dev/null
      amixer -D pulse sset Master 5%- > /dev/null
      send_notification
      ;;
    mute)
      # Toggle mute
      amixer -D pulse set Master 1+ toggle > /dev/null
      send_notification
      ;;
  esac
