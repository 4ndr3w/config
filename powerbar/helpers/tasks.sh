#!/bin/sh

while true; do
    echo T$(cat ~/TODO.txt | wc -l)
    sleep 120
#    inotifywait -e close_write TODO.txt &> /dev/null
done
