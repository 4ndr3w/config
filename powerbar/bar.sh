#!/bin/zsh

source ./colors.sh

WORKSPACES="..."
CLOCK="..."
BATTERY="..."
VOLUME="..."
while read -r line; do
	case $line in
		W*) # Workspace info
			WORKSPACES=${line#?}
		;;
		C*) # Clock
			CLOCK=${line#?}
		;;
		B*) # Battery
			BATTERY=${line#?}
		;;
		V*) # Volume
			VOLUME=${line#?}
		;;
	esac
	
	echo -n $ALIGN_LEFT$WORKSPACES
	echo -n $ALIGN_RIGHT

	echo -n $BACKGROUND_TEXT_COLOR
	
	echo -n $ARROW_LEFT
	echo -n $WHITE_TEXT
	echo -n $BACKGROUND_BACKGROUND_COLOR

#	echo -n " 音楽"
#	echo -n " Paused "

#	echo -n $ARROW_OUTLINE_LEFT

	echo -n " 音量 "
	echo -n "$VOLUME "
	
	echo -n $ARROW_OUTLINE_LEFT

	echo -n " 電池 "
	echo -n "$BATTERY "  

	echo -n $SELECTED_TEXT_BACKGROUND$ARROW_LEFT
	echo -n $SELECTED_BACKGROUND_BACKGROUND$SELECTED_TEXT_COLOR
	echo -n "$CLOCK "
	
	echo -n $BACKGROUND_TEXT_COLOR
	echo -n $ARROW_LEFT
	echo $ENDC
done
