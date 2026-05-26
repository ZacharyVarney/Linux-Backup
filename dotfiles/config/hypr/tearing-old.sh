#!/bin/bash

# Apply new settings
hyprctl keyword general:allow_tearing true
hyprctl keyword misc:vrr 0
hyprctl keyword cursor:no_break_fs_vrr 0
notify-send "Tearing Script" "Tearing Activated, VRR Disabled"

# Launch game (replace with actual launch command)
"$@"

# Restore original settings
hyprctl keyword general:allow_tearing false
hyprctl keyword misc:vrr 3
hyprctl keyword cursor:no_break_fs_vrr 2
notify-send "Tearing Script" "Tearing Deactivated, VRR Enabled"
