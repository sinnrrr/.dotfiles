#!/bin/sh

# turns a border on (not a toggle)

# only toggle if border is off
if [ $(yabai -m query --windows --window $1 | jq '."has-border"') = "false" ]; then
    yabai -m window $1 --toggle border
fi
