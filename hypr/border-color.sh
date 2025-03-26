#!/bin/bash

ANGLE=0  # Initial gradient angle

while true; do

    BATTERY_STATUS=$(cat /sys/class/power_supply/BAT0/status)
    BATTERY_LEVEL=$(cat /sys/class/power_supply/BAT0/capacity)
    
    # Increment angle (resets after 360°)
    ANGLE=$(( (ANGLE + 5) % 360 ))

    # Define gradient colors based on battery level & charging
    if [[ "$BATTERY_STATUS" == "Charging" ]]; then
        COLOR="0xff40fe0c 0xff7cf9bd ${ANGLE}deg"  # Light Green → Dark Green
        echo "Charging"
    elif [[ "$BATTERY_LEVEL" -ge 50 ]]; then
        COLOR="0xff0cf3fe 0xff0c0ffe ${ANGLE}deg"  # Cyan → Blue
        echo "battery above 50"
    elif [[ "$BATTERY_LEVEL" -ge 20 ]]; then
        COLOR="0xffffff00 0xffffa500 ${ANGLE}deg"  # Yellow → Orange
        echo "battery under 50"
    else
        COLOR="0xffff0000 0xff8b0000 ${ANGLE}deg"  # Red → Dark Red (Low Battery)
        echo "battery below 20"
    fi

    # Apply the changing gradient
    hyprctl keyword general:col.active_border "$COLOR"

    # Wait before updating again (smooth animation)
    sleep 0.15
done
