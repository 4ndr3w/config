#!/bin/sh

while true; do
    if [ "$(playerctl status)" == "Playing" ];
    then
        echo M$(playerctl metadata xesam:title) - $(playerctl metadata xesam:artist)
    else
        echo "MPaused"
    fi
    sleep 5
done
