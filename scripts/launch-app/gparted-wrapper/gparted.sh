#!/bin/bash

function run() {
    local STD_FILE="/mnt/data/pdata/gparted-wrapper/log.log"
    echo $'\n' >> $STD_FILE # append a newline
    launchGparted &>> $STD_FILE
}
function launchGparted() {
    local CMD='/usr/bin/sudo --preserve-env gparted'
    local GHOSTTY_CMD='/bin/bash'
    local INPUT=$CMD"$(printf '\r')"
    ghostty --working-directory=/tmp --title=gparted-run-sudo --input="$INPUT" -e $GHOSTTY_CMD
}
run
