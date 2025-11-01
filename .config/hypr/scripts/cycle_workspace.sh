#!/bin/bash

current_workspace=$(hyprctl activeworkspace -j | jq -r '.id')
max_workspace=5

if [ "$1" == "next" ]; then
    new_workspace=$((current_workspace + 1))
    if [ "$new_workspace" -gt "$max_workspace" ]; then
        new_workspace=1
    fi
elif [ "$1" == "prev" ]; then
    new_workspace=$((current_workspace - 1))
    if [ "$new_workspace" -lt 1 ]; then
        new_workspace=$max_workspace
    fi
fi

hyprctl dispatch workspace "$new_workspace"
