#!/bin/bash
PROTONCORE=(pv-bwrap pressure-vessel reaper explorer.exe rpcss.exe plugplay.exe services.exe svchost.exe winedevice.exe winedevice.exe wineserver gamescope gamescope-wl)

for PROG in "${PROTONCORE[@]}"; do
	killall -9 "$PROG"
done
