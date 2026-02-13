#!/bin/bash

export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
bun --global install --verbose \
    clipboard-cli \
    http-server \
    gnomon \
    pino-pretty \
    tree-sitter-cli \

