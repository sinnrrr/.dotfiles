#!/bin/sh

DESIRED_SPACES_PER_DISPLAY=${1:-4}
CURRENT_SPACES="$(yabai -m query --displays | jq -r '.[].spaces | @sh')"

DELTA=0
while read -r line
do
    EXISTING_SPACE_COUNT="$(echo "$line" | wc -w)"
    MISSING_SPACES=$(($DESIRED_SPACES_PER_DISPLAY - $EXISTING_SPACE_COUNT))
    if [ "$MISSING_SPACES" -gt 0 ]; then
        for i in $(seq 1 $MISSING_SPACES)
        do
            yabai -m space --create
        done
    elif [ "$MISSING_SPACES" -lt 0 ]; then
        for i in $(seq 1 $((-$MISSING_SPACES)))
        do
            yabai -m space --destroy 
        done
    fi
    DELTA=$(($DELTA+$MISSING_SPACES))
done <<< "$CURRENT_SPACES"
