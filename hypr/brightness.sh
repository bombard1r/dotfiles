#!/bin/bash

HOUR=$(date +%H)

if [ "$HOUR" -ge 7 ] && [ "$HOUR" -lt 21 ]; then
    BRIGHTNESS="100%"
else
    BRIGHTNESS="50%"
fi

brightnessctl set $BRIGHTNESS