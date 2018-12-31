#!/usr/bin/env bash

LGT=$(light -G | awk -F'.' '{ print $1 }')
bar=$(seq -s "─" $((LGT / 5)) | sed 's/[0-9]//g')

dunstify -a kogy-notif "$(printf "%4s" $LGT)   $bar" -r 424243
