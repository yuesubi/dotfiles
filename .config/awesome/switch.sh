#!/bin/bash


# Config paths
AWESOME_CFG_DIR="$HOME/.config/awesome"

NORMAL_CFG="$AWESOME_CFG_DIR/normal.lua"
WINDOWS_CFG="$AWESOME_CFG_DIR/windows.lua"
OUTPUT_CFG="$AWESOME_CFG_DIR/rc.lua"


# Use the config given as an argument
useCfg () {
    rm "$OUTPUT_CFG"
    cp "$1" "$OUTPUT_CFG"
}


config_choice="${1:no_param}"

# Switch to the explicit config asked for if there is one
if [ "$config_choice" == "normal" ]; then
    useCfg "$NORMAL_CFG"
elif [ "$config_choice" == "windows" ]; then
    useCfg "$WINDOWS_CFG"

# Swap the config that is being used
else
    current_cfg=`grep "^--CONFIG_NAME:" ${OUTPUT_CFG}`
    
    # Swap configs
    if [ "$current_cfg" == "--CONFIG_NAME:normal" ]; then
        useCfg "$WINDOWS_CFG"
    else
        useCfg "$NORMAL_CFG"
    fi
fi
