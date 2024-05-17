#!/bin/bash

systemctl --user start xsettingsd.service
echo "Xft.dpi: 120.00" | xrdb -merge
xrandr --output DP-1 --primary
