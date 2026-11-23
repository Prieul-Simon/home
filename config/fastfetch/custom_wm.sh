#!/bin/sh
fastfetch --structure wm --logo none --key-type none --pipe 2>/dev/null \
  | awk 'NR>1{printf " - "} {printf "%s", $0} END{print ""}' \
  | awk '{ if (length($0) > 50) print substr($0, 1, 45) "[...]"; else print }'