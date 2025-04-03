#!/bin/sh

# turns a border off (not a toggle)

# only toggle if border is on
if [ $(yabai -m query --windows --window $1 | jq '."has-border"') = "true" ]; then
    yabai -m window $1 --toggle border
fi
