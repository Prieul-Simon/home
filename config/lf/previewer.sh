#!/bin/sh

# if [ "$lf_user_hex_view" = true ]; then
#     hexdump -C "$1"
# else
#     batcat "$1"
# fi

# cat -b "$1"
batcat --paging=never --style=changes,numbers --color=always "$1"
# exit 1
