#!/bin/bash

# Apply new settings
hyprctl keyword cursor:no_hardware_cursors 1
hyprctl keyword cursor:no_break_fs_vrr 1
notify-send "No Break Cursor VRR Script" "Activated"

# Launch game (replace with actual launch command)
"$@"

# Restore original settings
hyprctl keyword cursor:no_hardware_cursors 0
hyprctl keyword cursor:no_break_fs_vrr 0
notify-send "No Break Cursor VRR Script" "Deactivated"
