#!/bin/sh

case "$1" in
    prev) yabai -m space --focus prev || yabai -m space --focus last ;;
    next) yabai -m space --focus next || yabai -m space --focus first ;;
    recent) yabai -m space --focus recent ;;
    *)
        if [[ -z $1 ]]; then
            if yabai -m query --windows --space |
            jq -er 'map(select(."has-focus" == true)) | length == 0' >/dev/null; then
                yabai -m window --focus mouse 2>/dev/null || true
            fi
        else
            yabai -m space --focus $1
        fi
        ;;
esac
