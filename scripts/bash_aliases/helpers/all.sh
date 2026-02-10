#!/bin/sh

source "${BASH_SOURCE%/*}/old.sh"
source "${BASH_SOURCE%/*}/dev.sh"
source "${BASH_SOURCE%/*}/python.sh"
source "${BASH_SOURCE%/*}/gnu.sh"
source "${BASH_SOURCE%/*}/hardware.sh"

if [ -f "${BASH_SOURCE%/*}/_private.sh" ]; then  
    source "${BASH_SOURCE%/*}/_private.sh"
fi
