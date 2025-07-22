#!/bin/bash

START_HOUR=23
END_HOUR=8
CURRENT_HOUR=$(date +%H)
CURRENT_HOUR=$((10#$CURRENT_HOUR))

if ([ "$START_HOUR" -le "$END_HOUR" ] && [ "$CURRENT_HOUR" -ge "$START_HOUR" ] && [ "$CURRENT_HOUR" -lt "$END_HOUR" ]) || \
   ([ "$START_HOUR" -gt "$END_HOUR" ] && ( [ "$CURRENT_HOUR" -ge "$START_HOUR" ] || [ "$CURRENT_HOUR" -lt "$END_HOUR" ] )); then
    if ! pgrep -x "hyprsunset" >/dev/null; then
    	echo '{"text":"   On"}'
        nohup hyprsunset --gamma 100 --gamma_max 100 --temperature 3500 >/dev/null 2>&1 &
    else
        echo '{"text":"   On"}'
    fi
else
    if pgrep -x "hyprsunset" >/dev/null; then
    	echo '{"text":"   Off"}'
        pkill -x "hyprsunset"
    else
    	echo '{"text":"   Off"}'
    fi
fi
