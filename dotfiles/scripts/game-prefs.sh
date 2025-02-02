#!/bin/bash

# Variables
MONITOR="DP-1" # Replace with your monitor name
RESOLUTION="2560x1440"
REFRESH_RATE="144"
POSITION="2201x947" # Format: x_offsetx_y_offset
SCALE="1.25"

# Enable VRR
echo "Enabling VRR for $MONITOR..."
hyprctl keyword monitor "$MONITOR,${RESOLUTION}@${REFRESH_RATE},${POSITION},${SCALE},vrr,2"

# taskset -c 0-7,16-23  # This is for 7950x3D CCD put it after MANGOHUD=1 to use.

# Launch the game in the background
echo "Launching the game..."
MANGOHUD=1 game-performance "$@" &
GAME_PID=$!

# Wait a moment to let the game window appear
sleep 3  

# Detect the game’s window class dynamically
GAME_WINDOW_CLASS=$(hyprctl clients | grep -A 3 "pid: $GAME_PID" | grep "class:" | awk '{print $2}')

if [ -n "$GAME_WINDOW_CLASS" ]; then
    echo "Applying tearing rule for window class: $GAME_WINDOW_CLASS"
    hyprctl keyword windowrulev2 "immediate, class:$GAME_WINDOW_CLASS"
else
    echo "Failed to detect game window class."
fi

# Wait for the game process to exit
wait $GAME_PID
GAME_EXIT_CODE=$?

# Remove the window rule after the game closes
if [ -n "$GAME_WINDOW_CLASS" ]; then
    echo "Removing tearing rule for window class: $GAME_WINDOW_CLASS"
    hyprctl keyword windowrulev2 "unset, class:$GAME_WINDOW_CLASS"
fi

# Disable VRR
echo "Disabling VRR for $MONITOR..."
hyprctl keyword monitor "$MONITOR,${RESOLUTION}@${REFRESH_RATE},${POSITION},${SCALE},vrr,0"
hyprctl reload

# Exit with the game's exit code
exit $GAME_EXIT_CODE
