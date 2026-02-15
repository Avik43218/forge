#!/bin/bash

ON_POWER_SCRIPT="/home/$USER/.local/bin/on_power.sh"
ON_BATTERY_SCRIPT="/home/$USER/.local/bin/on_battery.sh"
LOW_BATTERY_SCRIPT="/home/$USER/.local/bin/low_battery.sh"

AC_PATH="/sys/class/power_supply/ADP1/online"
BAT_PATH="/sys/class/power_supply/BAT0/capacity"

# Get initial state: 1 for AC, 0 for Battery
last_state=$(cat "$AC_PATH")
battery_level=$(cat "$BAT_PATH")

echo "Power monitor started. Current state: $last_state"

while true; do
    current_state=$(cat "$AC_PATH")

    if [ "$current_state" != "$last_state" ]; then
        if [ "$current_state" = "1" ]; then
            notify-send "Power Connected" "Switching to Live Video Wallpaper" -i battery-charging -a "Power Monitor" -t 3000
            bash "$ON_POWER_SCRIPT"
        else
            notify-send "Power Disconnected" "Switching to Image Wallpaper" -i battery-low -a "Power Monitor" -t 3000
            bash "$ON_BATTERY_SCRIPT"
        fi
        last_state=$current_state
    fi

    if [ $battery_level -lt 21 ]; then
        notify-send "Low Battery" "Switching to Power Saving Wallpaper" -i battery-caution -a "Power Monitor" -t 3000
        bash "$LOW_BATTERY_SCRIPT"
    fi

    # Check every 5 seconds
    sleep 5
done
