#!/bin/bash

DEVICE_MAC="38:D6:34:32:48:E4"

bluetoothctl power on

if ! bluetoothctl info $DEVICE_MAC | grep -q "Connected: yes"; then
    bluetoothctl connect $DEVICE_MAC
fi

hyprctl dispatch togglespecialworkspace magic

if pgrep -x spotify >/dev/null; then
    hyprctl dispatch togglespecialworkspace magic
    exit
fi

spotify &

while ! pgrep -x spotify >/dev/null; do sleep 0.5; done
sleep 1

hyprctl dispatch togglefloating
hyprctl dispatch resizeactive exact 1000 700
hyprctl dispatch centerwindow

hyprctl dispatch togglespecialworkspace magic

