#!/bin/sh

main() {
    # only works with Wi-Fi
    local interface=$(ip link show | rg wl | sd '\d+: (wl\w+):.*' '$1')
    echo "Found interface: $interface"
    resolvectl dns $interface 1.1.1.1 1.0.0.1
}
main
