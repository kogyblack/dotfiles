#!/usr/bin/env bash
source "$USERSCRIPT/rofi-widgets/wrapper/rofi.sh"

# Redirect stdout to /dev/null
#exec 1>/dev/null
# Redirect stderr to stdout
#exec 2>&1

# Override definitions in rofi-effects.sh
animationSpeed=20
maxOpacity=0.95

if [[ $(pgrep "rofi") ]]; then
	exit 1
fi

# Find cover
songPath="$HOME/Music/$(mpc current -f %file%)"
songDir="${songPath%/*}"
cover="$(find "$songDir" -type f -iname "cover-rofi.png")"

if [[ ! "$cover" ]]; then
	cover="$(find "$songDir" -type f -iname "*.png" -o -iname "*.jpg" | tail -n1)"
	if [[ "$cover" ]]; then
		convert "$cover" -resize 221x221\! "$songDir/cover-rofi.png"
		cover="$songDir/cover-rofi.png"
	fi
fi

rofi_load_vars mpc

rofi_dmenu "$cover" &
 
rofi_window_pop -

rofi_dmenu_read $!

if [ "$choice" ]; then
	mpc play "$choice"
else
	exit 1
fi
