#!/bin/bash

systemctl --user start xsettingsd.service
echo "Xft.dpi: 126" | xrdb -merge
xrandr --output DP-2 --primary
