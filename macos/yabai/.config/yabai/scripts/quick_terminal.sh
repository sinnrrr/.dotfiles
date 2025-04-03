#!/bin/sh

QuickTerminal=$(yabai -m query --windows | jq 'map(select(.title=="QuickTerminal")) | .[0].pid')


launch_kitty() {
    { kitty --single-instance --instance-group quickterm --title QuickTerminal --directory "${HOME}" tmux new -A -s quickterm & } &> /dev/null
    kitty_pid=$!
    disown -r "${kitty_pid}"
}

# launch_alacritty() {
#     open -n /Applications/Alacritty.app --args --title QuickTerminal
# }

quick_term_toggle() {
    osascript -e "
        tell application \"System Events\"
            if frontmost of the first process whose unix id is $1 then
                set visible of the first process whose unix id is $1 to false
            else
                set frontmost of the first process whose unix id is $1 to true
            end if
        end tell
    "
}


if [[ $QuickTerminal == "null" ]]; then
    launch_kitty
else
    quick_term_toggle $QuickTerminal
fi
