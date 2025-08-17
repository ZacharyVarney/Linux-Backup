#!/bin/bash

# This script is currently used when wanting tearing because VRR & allow_tearing does not work good together.

# Apply new settings
hyprctl keyword general:allow_tearing true
hyprctl keyword cursor:no_hardware_cursors 1
hyprctl keyword misc:vrr 0
notify-send "Tearing Script" "Tearing Activated, VRR Disabled"

# Launch game (replace with actual launch command)
"$@"

# Restore original settings
hyprctl keyword general:allow_tearing false
hyprctl keyword cursor:no_hardware_cursors 0
hyprctl keyword misc:vrr 3
notify-send "Tearing Script" "Tearing Deactivated, VRR Enabled"
