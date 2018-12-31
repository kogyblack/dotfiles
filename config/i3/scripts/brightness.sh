#!/usr/bin/env bash

# Usage
# $ ./brightness up
# $ ./brightness down

function get_brightness {
  light -G | awk -F'.' '{ print $1 }'
}

function send_notification {
  brightness=`get_brightness`
  # Make the bar with the special character ─ (it's not dash -)
  # https://en.wikipedia.org/wiki/Box-drawing_character
  bar="┠$(seq -s "─" $((1 + $brightness/ 5)) | sed 's/[0-9]//g')$(seq -s " " $((21 - $brightness/ 5)) | sed 's/[0-9]//g')┨"

  # Send the notification
  #dunstify -a kogy-notif -i brightness-display-symbolic -r 424243 "$(printf "%3s%%" $brightness)   $bar"
  dunstify -a kogy-notif -i display-brightness-symbolic -r 424243 "$(printf "%3s%%" $brightness)   $bar"
}

case $1 in
    up)
      light -A 8
      send_notification
      ;;
    down)
      light -U 8
      send_notification
      ;;
  esac
