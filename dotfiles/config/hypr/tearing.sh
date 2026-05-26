#!/bin/bash

# Apply new settings
hyprctl dispatch 'hl.config({general = {allow_tearing = true,},})'
hyprctl dispatch 'hl.config({misc = {vrr = 0,},})'
hyprctl dispatch 'hl.config({cursor = {no_break_fs_vrr = 0,},})'
notify-send "Tearing Script" "Tearing Activated, VRR Disabled"

# Launch game (replace with actual launch command)
"$@"

# Restore original settings
hyprctl dispatch 'hl.config({general = {allow_tearing = false,},})'
hyprctl dispatch 'hl.config({misc = {vrr = 3,},})'
hyprctl dispatch 'hl.config({cursor = {no_break_fs_vrr = 2,},})'
notify-send "Tearing Script" "Tearing Deactivated, VRR Enabled"
