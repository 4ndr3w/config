#!/bin/sh
while true;
do
	echo B$(acpi --battery | cut -d, -f2 | xargs)
	sleep 30
done
