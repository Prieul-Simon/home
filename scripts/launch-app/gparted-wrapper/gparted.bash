#!/bin/bash

function run() {
    local STD_FILE="$HOME/.local/state/gparted-wrapper/log.log"
    launchGparted &>> $STD_FILE
}
function launchGparted() {
    echo '' # append a newline
    echo "[$(date)]"
    local WORKING_DIR='/tmp'
    local CMD='/usr/bin/sudo --preserve-env /usr/sbin/gparted'
    local INPUT=$CMD"$(printf '\r')" # auto press <Enter> key
    local GHOSTTY_CMD='/bin/bash'
    echo "Starting ghostty with --working-directory=$WORKING_DIR --input=\"$CMD\" -e=\"$GHOSTTY_CMD\""
    ghostty --working-directory=$WORKING_DIR --title='GParted run as sudo' --input="$INPUT" -e $GHOSTTY_CMD
}
run
