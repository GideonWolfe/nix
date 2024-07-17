#!/usr/bin/env -S nix shell nixpkgs#bash --command bash

MAKO_MODES=$(makoctl mode) 


# Returns the status string/tooltip for waybar to consume
if [ "$1" == "status" ]; then
    if echo "$MAKO_MODES" | grep -q "do-not-disturb"; then
		printf '{"text":"", "tooltip":"Do Not Disturb: Enabled"}\n'
    else
		printf '{"text":"", "tooltip":"Do Not Disturb: Disabled"}\n'
    fi

# Checks current mako status and toggles it
elif [ "$1" == "toggle" ]; then
    if echo "$MAKO_MODES" | grep -q "do-not-disturb"; then
        makoctl mode -r "do-not-disturb" > /dev/null
        notify-send "Do Not Disturb" "Disabled"
    else
        makoctl mode -a "do-not-disturb" > /dev/null
        notify-send "Do Not Disturb" "Enabled"
    fi
fi
