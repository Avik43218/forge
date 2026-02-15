#!/bin/bash

SOUND_HIGH="/usr/share/sounds/freedesktop/stereo/power-plug.oga"
SOUND_LOW="/usr/share/sounds/freedesktop/stereo/power-unplug.oga"

ALREADY_NOTIFIED_HIGH=false
ALREADY_NOTIFIED_LOW=false

while true; do
    LEVEL=$(cat /sys/class/power_supply/BAT0/capacity)
    STATUS=$(cat /sys/class/power_supply/BAT0/status)

    if [ "$LEVEL" -ge 80 ] && [ "$STATUS" = "Charging" ]; then
        if [ "$ALREADY_NOTIFIED_HIGH" = false ]; then
            notify-send -i battery-full -t 5000 "Unplug Now" "Battery at $LEVEL%" -a "Battery Health Monitor"
            paplay "$SOUND_HIGH"
            ALREADY_NOTIFIED_HIGH=true
            ALREADY_NOTIFIED_LOW=false
        fi

    elif [ "$LEVEL" -le 40 ] && [ "$STATUS" = "Discharging" ]; then
        if [ "$ALREADY_NOTIFIED_LOW" = false ]; then
            notify-send -i battery-caution -t 5000 "Plug-in Now" "Battery at $LEVEL%" -a "Battery Health Monitor"
            paplay "$SOUND_LOW"
            ALREADY_NOTIFIED_LOW=true
            ALREADY_NOTIFIED_HIGH=false
        fi

    elif [ "$LEVEL" -gt 41 ] && [ "$LEVEL" -lt 79 ]; then
        ALREADY_NOTIFIED_HIGH=false
        ALREADY_NOTIFIED_LOW=false
    fi

    sleep 60
done
