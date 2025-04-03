#!/bin/sh

# Only have borders/gaps/padding if there is >1 VISIBLE window

if [[ -z "${YABAI_SPACE_ID}" ]]; then
    space_sel="mouse"
else
    space_sel=$(yabai -m query --spaces | jq -r '.[] | select(.id==(env.YABAI_SPACE_ID|tonumber)).index')
fi

windows_ids=$(yabai -m query --windows --space $space_sel | jq '.[] | select(."is-floating"==false).id')
windows_count=$(echo $windows_ids | wc -w)

if [[ $windows_count -eq 0 ]]; then
    exit 0
fi
if [[ $windows_count -eq 1 ]]; then
    p=0
    yabai -m space $space_sel --padding abs:$p:$p:$p:$p
    echo $windows_ids | xargs -n1 -P10 $YABAI/border_off.sh
    yabai -m space $space_sel --gap abs:$p
else
    p=4
    yabai -m space $space_sel --padding abs:$p:$p:$p:$p
    echo $windows_ids | xargs -n1 -P10 $YABAI/border_on.sh
    yabai -m space $space_sel --gap abs:8
fi
