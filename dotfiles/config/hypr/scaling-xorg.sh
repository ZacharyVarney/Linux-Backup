#!/bin/bash

systemctl --user start xsettingsd.service
echo "Xft.dpi: 128" | xrdb -merge
xrandr --output DP-2 --primary
