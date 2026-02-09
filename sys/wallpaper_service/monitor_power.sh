#!/bin/bash

ON_POWER_SCRIPT="/home/$USER/.local/bin/on_power.sh"
ON_BATTERY_SCRIPT="/home/$USER/.local/bin/on_battery.sh"

AC_PATH="/sys/class/power_supply/ADP1/online"

# Get initial state: 1 for AC, 0 for Battery
last_state=$(cat "$AC_PATH")

echo "Power monitor started. Current state: $last_state"

while true; do
    current_state=$(cat "$AC_PATH")

    if [ "$current_state" != "$last_state" ]; then
        if [ "$current_state" = "1" ]; then
            notify-send "Power Connected" "Running on_power.sh" -i battery-charging -a "Power Monitor"
            bash "$ON_POWER_SCRIPT"
        else
            notify-send "Power Disconnected" "Running on_battery.sh" -i battery-low -a "Power Monitor"
            bash "$ON_BATTERY_SCRIPT"
        fi
        last_state=$current_state
    fi

    # Check every 5 seconds
    sleep 5
done
