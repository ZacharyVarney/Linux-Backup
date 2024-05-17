#!/bin/bash

systemctl --user start xsettingsd.service
echo "Xft.dpi: 120" | xrdb -merge
xrandr --output DP-1 --primary
