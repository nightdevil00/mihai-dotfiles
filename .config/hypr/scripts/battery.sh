#!/bin/bash
BATTERY_DIR=$(find /sys/class/power_supply -name 'BAT*' | head -n 1)
if [ -d "$BATTERY_DIR" ]; then
    STATUS=$(cat "$BATTERY_DIR/status")
    CAPACITY=$(cat "$BATTERY_DIR/capacity")
    echo "Battery: $CAPACITY% ($STATUS)"
else
    echo "Battery: N/A"
fi
