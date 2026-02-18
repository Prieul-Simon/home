#!/bin/bash

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
echo 'Installing Node.js (stable version)...'
nvm install stable
echo 'Installing Node.js (LTS version)...'
nvm install 'lts/*'
