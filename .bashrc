#!/bin/bash

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls -lAh --color=auto'


#Black        0;30     Dark Gray     1;30
#Red          0;31     Light Red     1;31
#Green        0;32     Light Green   1;32
#Brown/Orange 0;33     Yellow        1;33
#Blue         0;34     Light Blue    1;34
#Purple       0;35     Light Purple  1;35
#Cyan         0;36     Light Cyan    1;36
#Light Gray   0;37     White         1;37

# COLORS
no_color='\033[0m'
black='\033[0;30m'
dark_gray='\033[1;30m'
red='\033[0;31m'
light_red='\033[1;31m'
green='\033[0;32m'
light_green='\033[1;32m'
orange='\033[0;33m'
yellow='\033[1;33m'
blue='\033[0;34m'
light_blue='\033[1;34m'
purple='\033[0;35m'
light_purple='\033[1;35m'
cyan='\033[0;36m'
light_cyan='\033[1;36m'
light_gray='\033[0;37m'
white='\033[1;37m'


if [ "$TERM" = "linux" ]; then
    echo -en "\e]P0000000" #black
    echo -en "\e]P84D4D4D" #darkgrey
    echo -en "\e]P1FF5555" #darkred
    echo -en "\e]P9FF6E67" #red
    echo -en "\e]P250FA7B" #darkgreen
    echo -en "\e]PA5AF78E" #green
    echo -en "\e]P3F1FA8C" #brown
    echo -en "\e]PBF4F99D" #yellow
    echo -en "\e]P4BD93F9" #darkblue
    echo -en "\e]PCCAA9FA" #blue
    echo -en "\e]P5FF79C6" #darkmagenta
    echo -en "\e]PDFF92D0" #magenta
    echo -en "\e]P68BE9FD" #darkcyan
    echo -en "\e]PE9AEDFE" #cyan
    echo -en "\e]P7BFBFBF" #lightgrey
    echo -en "\e]PFE6E6E6" #white
    #clear #for background artifacting
fi


PS1="${light_blue}[${blue}\u ${cyan}\W${light_blue}]${no_color} \$ "

if [[ $(ps --no-header --pid=$PPID --format=cmd) != "fish" && -z ${BASH_EXECUTION_STRING} ]]
then
	exec fish
fi

. "$HOME/.cargo/env"
