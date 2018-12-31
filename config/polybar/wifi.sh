#!/usr/bin/env bash

nmcli d wifi list
printf '\n\n Type the following to connect to a wireless network: \n\n $ nmcli dev wifi connect <SSID>\n\n'
bash --norc
