#!/bin/sh

cd `dirname $0`

PANEL_FIFO="/tmp/topbar.pipe"

trap 'trap - TERM; kill 0' INT TERM QUIT EXIT

[ -e "$PANEL_FIFO" ] && rm "$PANEL_FIFO"
mkfifo "$PANEL_FIFO"

python helpers/powerline-bar.py  &
./helpers/clock.sh  &
./helpers/battery.sh  &
./helpers/volume.sh  & 
./helpers/music.sh  &
./helpers/wanikani.py  &
