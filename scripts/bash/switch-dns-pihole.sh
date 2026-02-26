#!/bin/sh

main() {
    # only works with Wi-Fi
    local interface=$(ip link show | rg wl | sd '\d+: (wl\w+):.*' '$1')
    echo "Found interface: $interface"
    resolvectl dns $interface 192.168.1.2
}
main
