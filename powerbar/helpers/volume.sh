#!/bin/sh

while true; do
	echo V$(amixer get Master | sed -n 's/^.*\[\([0-9]\+\)%.*$/\1/p' | uniq)
	sleep 5 
done
