#!/bin/sh


COMMITNOTIFICATION=$(git log -1 HEAD --format=reference)
notify-send 'Git Commit Success' "$COMMITNOTIFICATION" -u low
