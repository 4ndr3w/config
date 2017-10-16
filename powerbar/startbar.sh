#!/bin/sh

cd `dirname $0`

PANEL_FIFO="/tmp/topbar.pipe"

trap 'trap - TERM; kill 0' INT TERM QUIT EXIT

[ -e "$PANEL_FIFO" ] && rm "$PANEL_FIFO"
mkfifo "$PANEL_FIFO"

python helpers/powerline-bar.py > $PANEL_FIFO &
./helpers/clock.sh > $PANEL_FIFO &
./helpers/battery.sh > $PANEL_FIFO &
./helpers/volume.sh > $PANEL_FIFO & 
./bar.sh < $PANEL_FIFO | lemonbar -p -f "Source Code Pro for Powerline:size=10" -f "Source Han Sans JP:size=9" -g 1318x16+0+0
