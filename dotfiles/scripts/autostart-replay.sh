#!/bin/sh

sleep 5
pidof -q gpu-screen-recorder && exit 0
video_path="$HOME/Videos"
mkdir -p "$video_path"
gpu-screen-recorder -w DP-1 -f 60 -a "default_output|default_input" -c mp4 -k h264 -ac opus -r 60 -fm vfr -o "$video_path"
