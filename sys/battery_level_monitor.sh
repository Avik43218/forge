#!/bin/bash

USER=$(id -u)

BAT_PATH="/sys/class/power_supply/BAT0/capacity"
AC_PATH="/sys/class/power_supply/ADP1/online"
LOG_FILE="/home/$USER/.battery.log"

START_TIME=$SECONDS
CURRENT_LEVEL=$(cat "$BAT_PATH")
CURRENT_STATE=$(cat "$AC_PATH")

echo -e "\n--- Battery Monitor Started at $(date) ---" >> "$LOG_FILE"
echo "Monitoring Battery... Logging Into $LOG_FILE"

while true; do
	NEW_LEVEL=$(cat "$BAT_PATH")

	if [ "$NEW_LEVEL" != "$CURRENT_LEVEL" ] && [ "$CURRENT_STATE" == "0" ]; then
		END_TIME="$SECONDS"
		DURATION=$((END_TIME - START_TIME))

		LOG_ENTRY="$(date '+%Y-%m-%s %H:%M:%S') | Level: ${CURRENT_LEVEL}% | Duration: ${DURATION} s"
		echo "$LOG_ENTRY" >> "LOG_FILE"

		CURRENT_LEVEL=$NEW_LEVEL
		START_TIME=$SECONDS

	fi

	sleep 2
done



