#!/usr/bin/env -S nix shell nixpkgs#bash --command bash


DECISION=$(printf "yes\nno" | wofi --prompt="are you sure?" --dmenu)


if [[ "$DECISION" == "yes" ]]; then
	systemctl reboot
elif [[ "$DECISION" == "no" ]]; then
	notify-send -t 5000 -u low "System" " Reboot Aborted"
	exit
else
	exit
fi
