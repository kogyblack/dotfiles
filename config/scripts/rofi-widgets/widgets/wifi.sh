#!/bin/zsh
source "$USERSCRIPT/rofi-widgets/wrapper/rofi.sh"

# Redirect stdout to /dev/null
#exec 1>/dev/null
# Redirect stderr to stdout
#exec 2>&1

if [[ $(pgrep "rofi") ]]; then
  exit 1
fi


wifi_set_connection(){
  local color="%{u$(cat "$HOME/.cache/wal/colors.json" | jq -r '.colors.color15')}"
  local nocolor="%{u-}"

  rofi_load_vars sound

  rofi_dmenu &

  rofi_window_pop +

  rofi_dmenu_read

  $choice=awk 

  if [ "$choice" ]; then
    pactl set-default-sink "${choice:0:1}"
  else
    exit 1
  fi
}
