#!/bin/bash

clients=$(hyprctl clients -j)

# Build numbered menu mapping: index|address|display
menu=$(echo "$clients" \
    | jq -r '.[] | .address + "|" + (.class + ": " + .title)' \
    | nl -w2 -s'|')

# Walker sees only "index) display"
choice=$(echo "$menu" | awk -F'|' '{print $1 ") " $3}' | walker --dmenu)

# Extract chosen index
index=$(echo "$choice" | awk -F')' '{print $1}' | tr -d '[:space:]')

# Lookup address by index
address=$(echo "$menu" | awk -F'|' -v idx="$index" '$1==idx {print $2; exit}')

# Focus the window
[ -n "$address" ] && hyprctl dispatch focuswindow "address:$address"
