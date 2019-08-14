#!/bin/sh
source "$USERSCRIPT/rofi-widgets/wrapper/rofi.sh"

# Redirect stdout to /dev/null
exec 1>/dev/null
# Redirect stderr to stdout
exec 2>&1

if [[ $(pgrep "rofi") ]]; then
  exit 1
fi

rofi_load_vars power

rofi_dmenu &

rofi_window_show

rofi_dmenu_read

if [ "$choice" = "1" ]; then
  #sudo poweroff
  poweroff
elif [ "$choice" = "2" ]; then
  #sudo reboot
  poweroff --reboot
#elif [ "$choice" = "3" ]; then
#  echo "Suspend"
#  sudo s2ram
else
  exit 1
fi
