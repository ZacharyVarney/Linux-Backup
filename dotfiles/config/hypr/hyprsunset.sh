#!/bin/bash

ENABLED=0
START_HOUR=23
END_HOUR=8
CURRENT_HOUR=$(date +%H)
CURRENT_HOUR=$((10#$CURRENT_HOUR))

if [ "$ENABLED" -eq 0 ]; then
	if pgrep -x "hyprsunset" >/dev/null; then
		echo '{"text":"   Off","tooltip":"Hyprsunset is Disabled"}'
		pkill -x "hyprsunset"
		exit 0
	else
		echo '{"text":"   Off","tooltip":"Hyprsunset is Disabled"}'
		exit 0
	fi
else
	if ([ "$START_HOUR" -le "$END_HOUR" ] && [ "$CURRENT_HOUR" -ge "$START_HOUR" ] && [ "$CURRENT_HOUR" -lt "$END_HOUR" ]) || \
	   ([ "$START_HOUR" -gt "$END_HOUR" ] && ( [ "$CURRENT_HOUR" -ge "$START_HOUR" ] || [ "$CURRENT_HOUR" -lt "$END_HOUR" ] )); then
	    if ! pgrep -x "hyprsunset" >/dev/null; then
	    	echo '{"text":"   On","tooltip":"Hyprsunset is Enabled"}'
	        nohup hyprsunset --gamma 100 --gamma_max 100 --temperature 3300 >/dev/null 2>&1 &
	        exit 0
	    else
	        echo '{"text":"   On","tooltip":"Hyprsunset is Enabled"}'
	        exit 0
	    fi
	else
	    if pgrep -x "hyprsunset" >/dev/null; then
	    	echo '{"text":"   Off","tooltip":"Hyprsunset is Enabled"}'
	        pkill -x "hyprsunset"
	        exit 0
	    else
	    	echo '{"text":"   Off","tooltip":"Hyprsunset is Enabled"}'
	    	exit 0
	    fi
	fi
fi
