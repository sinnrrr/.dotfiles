#!/bin/sh

if [ -z "$1" ]; then
  echo "Please provide the desired number of spaces per display"
  exit 1
fi

CURRENT_OPEN_SPACES=$(yabai -m query --spaces | jq length)
CURRENT_CONNECTED_DISPLAYS=$(yabai -m query --displays | jq length)

DESIRED_SPACES=$(($1 + CURRENT_CONNECTED_DISPLAYS - 1))
DELTA=$((DESIRED_SPACES - CURRENT_OPEN_SPACES))

while [ $DELTA -ne 0 ]; do
  echo $DELTA
  if [ $DELTA -gt 0 ]; then
    yabai -m space --create
    DELTA=$((DELTA - 1))
  else
    yabai -m space --destroy
    DELTA=$((DELTA + 1))
  fi
done
