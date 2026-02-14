#!/bin/bash

# setup-completions will need node, so lload it
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# Execute the bun scripts within a bash shell
bun $HOME/utils/scripts/bun/setup-completions.ts
bun $HOME/utils/scripts/bun/setup-git.ts
