#!/usr/bin/env -S nix shell nixpkgs#bash --command bash

PROMPTCOMMAND='printf "yes\nno" | wofi --prompt="are you sure?" --dmenu '

#DECISION=$($PROMPTCOMMAND)
DECISION=$(printf "yes\nno" | wofi --prompt="Power Off: are you sure?" --dmenu)


#if [ $DECISION = "yes" ]; then
if [[ "$DECISION" == "yes" ]]; then
	systemctl poweroff
#elif [ $DECISION = "no" ]; then
elif [ "$DECISION" == "no" ]; then
	notify-send -t 5000 -u low "System" " Power off Aborted"
	exit
else
	exit
fi
