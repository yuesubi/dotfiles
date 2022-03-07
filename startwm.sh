#!/bin/bash


## Chose window manager #
#echo -n ">>> "
#read choice


# Uses the choice specified as a parametter
choice="${1:awesome}"


### Starting the window manager chosen
if [ "$choice" == "awesome" ]; then	
	exec startx ~/.config/xinits/awesome

elif [ "$choice" == "dwm" ]; then
	exec startx ~/.config/xinits/dwm

elif [ "$choice" == "qtile" ]; then
	exec startx ~/.config/xinits/qtile

elif [ "$choice" == "kde" ]; then
	exec startx ~/.config/xinits/kde

elif [ "$choice" == "gnome" ]; then
	exec startx ~/.config/xinits/gnome

else
	echo "\033[0;33mNo window managers were launched"
fi
