#!/bin/bash

DMEDITOR="alacritty -e vim" 


declare -a config_files=(
    "alacritty - $HOME/.config/alacritty/alacritty.yml"
    "awesome - $HOME/.config/awesome/rc.lua"
    "bash - $HOME/.bashrc"
    "neovim - $HOME/.config/nvim/init.vim"
    "picom - $HOME/.config/picom/picom.conf"
    "qtile - $HOME/.config/qtile/config.py"
    "quit"
)


choice=$(printf '%s\n' "${config_files[@]}" | dmenu -i -l 20 -p 'Edit config:')


if [[ "$choice" == "quit" ]]; then
    echo "Program terminated" && exit 1

elif [ "$choice" ]; then
    cfg=$(printf '%s\n' "$choice" | awk '{print $NF}')
    $DMEDITOR "$cfg"

else
    echo "Program terminated" && exit 1
fi
