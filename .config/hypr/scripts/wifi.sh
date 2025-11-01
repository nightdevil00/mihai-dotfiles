#!/bin/bash
SSID=$(iwctl station list | grep connected | awk '{print $4}')
if [ -n "$SSID" ]; then
    echo "Wifi: $SSID"
else
    echo "Wifi: Not connected"
fi