#!/bin/zsh
source "$USERSCRIPT/rofi-widgets/wrapper/rofi.sh"

# Redirect stdout to /dev/null
#exec 1>/dev/null
# Redirect stderr to stdout
#exec 2>&1

if [[ $(pgrep "rofi") ]]; then
	exit 1
fi

animationSpeed=10

USBICON=禍
HDMIICON=﴿
PCIICON=

pulse_get_devices_polybar(){
	local colorRunningOverline="%{o$(cat "$HOME/.cache/wal/colors.json" | jq -r '.colors.color1')}"
	local colorDefaultUnderline="%{u$(cat "$HOME/.cache/wal/colors.json" | jq -r '.colors.color4')}"
	local nocolorUnderline="%{u$(cat "$HOME/.cache/wal/colors.json" | jq -r '.colors.color0')}"
	local nocolorOverline="%{o$(cat "$HOME/.cache/wal/colors.json" | jq -r '.colors.color0')}"

	defaultSink=$(pactl info | awk -F: '/Default Sink/ {print $2}')


	while read line; do
		echo -ne "$nocolorOverline"
		echo -ne "$nocolorUnderline"

		if [[ "$line" =~ "$defaultSink" ]]; then
			echo -ne "$colorDefaultUnderline"
		fi

		if [[ "$line" =~ "RUNNING" ]]; then
			echo -ne "$colorRunningOverline"
		fi

		if [[ "$line" =~ "usb" ]]; then
			echo -ne "  $USBICON  "
		elif [[ "$line" =~ "HDMI" ]]; then
			echo -ne "  $HDMIICON  "
		else
			echo -ne "  $PCIICON  "
		fi

		echo -ne "$nocolorOverline"
		echo -ne "$nocolorUnderline"
	done <<< $(pactl list sinks | awk -F# ' \
                          /Sink/ {ORS=" "; print $2; FS=" "} /\<State\>/ {ORS=" "; print $2; FS=" "} \
                          /Name/ {ORS=" "; print $2; FS="="} \
                          /alsa.card_name/ {ORS=" "; print $2; FS=" "} \
                          /\<device.bus\>/ {ORS="\n"; print $3; FS="#"}')
}

pulse_set_devices_rofi(){
	local color="%{u$(cat "$HOME/.cache/wal/colors.json" | jq -r '.colors.color15')}"
	local nocolor="%{u-}"

	rofi_load_vars sound

	rofi_dmenu &

	rofi_window_pop +

	rofi_dmenu_read

	if [ "$choice" ]; then
		pactl set-default-sink "${choice:0:1}"
	else
		exit 1
	fi
}
