#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
#while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# get colors
source ~/.cache/wal/colors.sh

export fg="#FF${color15/'#'}"
export bg="#80${color0/'#'}"
export fg_prefix="#DD${color8/'#'}"
export fg_alert="#FF${color1/'#'}"
export bg_alert="#BF${color1/'#'}"
export sep="#CC${color5/'#'}"
export bar_primary="#FF${color12/'#'}"
export bar_secondary="#FF${color16/'#'}"
export bar_sep="#CC${color3/'#'}"

# Launch
polybar top &
