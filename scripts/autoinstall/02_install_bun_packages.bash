#!/bin/bash

export BUN_INSTALL="$HOME/.local/share/bun"
$BUN_INSTALL/bin/bun --global install \
    clipboard-cli \
    http-server \
    gnomon \
    pino-pretty \
    tree-sitter-cli \

