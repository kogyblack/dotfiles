#!/usr/bin/env bash

'''
Nvidia + XOrg interaction
.xprofile: xrandr --auto

disable PC speaker beep
.xprofile: xset -b

Enable touchpad natural scrolling (move to i3 config?)
xinput list -> find touchpad device name
.xprofile: xinput set-prop "DLL0798:00 06CB:7E92 Touchpad" "libinput Natural Scrolling Enabled" 1
'''

'''
system installs:
konsole

xorg-xinput

pavucontrol (pulse audio visual controller)

light (backlight control) (used on i3 light control)
otf-font-awesome (ttf is broken) (used on polybar)
alsa-utils (audio stuff) (used on i3 volume control)
sysstat (cpu stuff) (used on polybar?)
gnome-screenshot (screenshot software) (bugged config on i3?)


i3 installs:
i3-gaps
polybar
xlock

feh (image viewer / background images)
rofi (program launcher)


not being used usually:
# file manager
ranger (file explorer)
w3m (image viewer?) (used in ranger)

# i3-save-layout
tty-clock
cava (music equalizer)
gotop (system monitor)
perl-anyevent-i3 (missing dependency to run i3-save-layout)

# music control
playerctl
# test mpd + npcmcpp (+ spotify)

# TEST if is being used or not!
xf86-input-libinput
'''

'''
TODO:
auto start workspaces (?)
apply pywal theme
email (thunderbird?)
'''
