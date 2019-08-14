#!/usr/bin/env bash
source "$USERSCRIPT/rofi-widgets/wrapper/rofi-effects.sh"

rofi -modi drun -show drun &

if ! rofi_window_find ; then echo "fail" ; fi
echo $winId

xdotool windowmap --sync $winId

transset-df -i $winId 1
