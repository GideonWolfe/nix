#!/usr/bin/env -S nix shell nixpkgs#bash --command bash
# Based on https://gitlab.com/anarcat/scripts/-/blob/main/sway-window-menu

set -e

hyprctl dispatch focuswindow address:"$(hyprctl -j clients | jq 'map("\(.workspace.id) ∴ \(.workspace.name) ┇ \(.title) ┇ \(.address)")' | sed "s/,$//; s/^\[//; s/^\]//; s/^[[:blank:]]*//; s/^\"//; s/\"$//" | grep -v "^$" | wofi -dO alphabetical -i | grep -o "0x.*$")"
