#!/usr/bin/env -S nix shell nixpkgs#bash --command bash

MAKO_MODES=$(makoctl mode) 


#TODO: do these signals actually work? maybe we can get update speed up

# Returns the status string/tooltip for waybar to consume
if [ "$1" == "status" ]; then
    if echo "$MAKO_MODES" | grep -q "do-not-disturb"; then
		printf '{"text":"", "tooltip":"Do Not Disturb: Enabled"}\n'
        pkill -RTMIN+8 waybar
    else
		printf '{"text":"", "tooltip":"Do Not Disturb: Disabled"}\n'
        pkill -RTMIN+8 waybar
    fi

# Checks current mako status and toggles it
elif [ "$1" == "toggle" ]; then
    if echo "$MAKO_MODES" | grep -q "do-not-disturb"; then
        makoctl mode -r "do-not-disturb" > /dev/null
        pkill -RTMIN+8 waybar
        notify-send "Do Not Disturb" "Disabled"
    else
        makoctl mode -a "do-not-disturb" > /dev/null
        pkill -RTMIN+8 waybar
        notify-send "Do Not Disturb" "Enabled"
    fi
fi
