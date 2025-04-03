#!/bin/sh

notify "Yabai" "Restarting Yabai and skhd"
yabai --restart-service
# skhd -r &
