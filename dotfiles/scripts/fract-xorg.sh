#!/bin/bash

# This script achieves the JANK workaround to achieve mixed monitor scaling on X11 & with very minimal quality loss

# Calculate DPI for 1.25 scale on primary monitor
PRIMARY_DPI=$(echo "scale=0; 96 * 1.25" | bc)

# Set Xft.dpi
echo "Xft.dpi: ${PRIMARY_DPI}" | xrdb -merge

# Set display properties for primary display with the 1.25 scale
xrandr --output DisplayPort-0 --mode 2560x1440 --rate 144 --primary --pos 2400x0

# Set display properties for secondary displays while scaling them down by 1.25
xrandr --output HDMI-A-0 --mode 1920x1080 --rate 60 --scale 1.25x1.25 --pos 0x0
xrandr --output DisplayPort-1  --mode 1920x1080 --rate 60 --scale 1.25x1.25 --pos 4960x0

# Ensure settings applied to xsettingsd for use
sleep 1
systemctl --user restart xsettingsd.service
