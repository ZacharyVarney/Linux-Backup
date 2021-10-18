#!/bin/bash

# List of applications to run
APPS=(
    ~/.config/awesome/wallpaper.sh
    flameshot
    volumeicon
    picom
    lxsession
    ~/Documents/nvidia-power.sh
    )

# Some applications start child applications that need to be killed on reload
KILL=(
    volumeicon
    lxsession
    ssh-agent
    )

# First kill lingering apps
for app in "${APPS[@]}"
do
    kill -9 $(pidof $app)
done
for app in "${KILL[@]}"
do
    kill -9 $(pidof $app)
done

# Start new instances
for app in "${APPS[@]}"
do
    env $app ${@:2} &
done
