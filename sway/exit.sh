#!/bin/bash

if [[ ! $(pgrep -x "swaynag") ]]; then
    swaynag --background 333333 --border 333333 --border-bottom 333333 --button-background 1F1F1F \
            --button-border-size 0 --button-padding 8 --text FFFFFF --button-text FFFFFF --edge bottom \
            -t warning -m 'Choose an action:' \
            -B 'Lock Screen' 'exec bash ~/.config/swaylock/lock.sh' \
            -B 'Log Out' 'swaymsg exit' \
            -B 'Reboot' 'systemctl reboot' \
            -B 'Suspend' 'systemctl suspend' \
            -B 'Shutdown' 'systemctl poweroff'
fi
