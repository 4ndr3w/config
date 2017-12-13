#!/bin/sh

while true; do
    VOLUME_ENABLED=$(amixer get Master | tail -n 1 | cut -d '[' -f 3 | sed 's/].*//g')
    echo -n V$(amixer get Master | sed -n 's/^.*\[\([0-9]\+\)%.*$/\1/p' | uniq)
    if [ "$VOLUME_ENABLED" == "off" ]; then
        echo -n " ミュート"
    fi
    echo

    if [ "$ONCE" == "yes" ]; then
        exit
    fi
    sleep 5 
done
