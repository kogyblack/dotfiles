#!/usr/bin/env bash

VOL=$(amixer sget Master | awk -F"[][]" '/\[[0-9]*%\]/ { print $2; exit }')

bar=$(seq -s "─" $((${VOL%?} / 5)) | sed 's/[0-9]//g')

#dunstify "Volume>" "$(printf "%4s" $VOL)    $bar" -r 424242
dunstify -a kogy-notif "$(printf "%4s" $VOL)   $bar" -r 424242

# beep
aplay beep.ogg
