#!/bin/bash

# Get the current volume
volume=$(pamixer --get-volume)

# Get mute status (1 if muted, 0 if not)
mute_status=$(pamixer --get-mute)

# Set default icon path
icon=""

# Check mute status first
if [ "$mute_status" == "true" ]; then
    icon="/home/bbrdr/Downloads/volume-silent.png"  # Icon for muted volume
elif [ "$volume" -ge 75 ]; then
    icon="/home/bbrdr/Downloads/volume.png"  # High volume icon
elif [ "$volume" -le 25 ]; then
    icon="/home/bbrdr/Downloads/volume-low.png"  # Low volume icon
else
    icon="/home/bbrdr/Downloads/volume-medium.png"  # Medium volume icon
fi

replaces_id="178324"
# Send notification with the selected icon
notify-send -i "$icon" -r "$replaces_id" "Volume" "Volume is at $volume%"
