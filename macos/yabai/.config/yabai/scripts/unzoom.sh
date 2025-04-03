#!/bin/sh

if [[ $(yabai -m query --windows --window | jq -r '."has-fullscreen-zoom"') == "true" ]]; then
    yabai -m window --toggle zoom-fullscreen
fi
