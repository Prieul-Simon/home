#!/bin/bash

# Change working directory
cd $HOME/utils/scripts/bun/
# bun
export BUN_INSTALL="$HOME/.local/share/bun"
export PATH="$BUN_INSTALL/bin:$PATH"
# setup-completions will need node, so load it
export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# bun
bun install
# Execute the bun scripts within a bash shell
bun $HOME/utils/scripts/bun/setup-completions.ts
bun $HOME/utils/scripts/bun/setup-git.ts
