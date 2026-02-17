## Source common helpers with bash shell
bass source $HOME/utils/scripts/bash_aliases/core/all.sh

## Improve even more ls & other aliases
# Now silently use eza instead of ls
set -l __UNSET_MSG ' unset by purpose in aliases.fish'
alias l "echo 'l'$__UNSET_MSG"
alias la "echo 'la'$__UNSET_MSG"
alias ll "echo 'll'$__UNSET_MSG"
alias ls el
alias ll ellla
alias grep 'grep --color=always'
alias fgrep 'fgrep --color=always'
alias egrep 'egrep --color=always'
alias bat batcat

## Utilities
alias boo='ghostty +boo'
alias python='python3'
alias fake-mail='python -m smtpd -n -c DebuggingServer localhost:25'

## Better commands
# TODO from importme.bash_aliases.bash

## Use npmjs.com packages installed globally with Bun
alias cb='bun run --bun --no-install clipboard'
alias bun_httpserver='bun run --no-install http-server' # Need Node.js/nvm as it does not work with Bun runtime
alias bun_gnomon='bun run --bun --no-install gnomon'
alias prettylog="bun run --bun --no-install pino-pretty"
set __SIMON_TLDR_NODE_CLIENT "$DATA_PATH/dev/_ext/tldr-node-client/bin/tldr"
alias tldr-bun="bun run --bun $__SIMON_TLDR_NODE_CLIENT"
alias tldr-node="$__SIMON_TLDR_NODE_CLIENT"
alias tree-sitter="bun run --bun --no-install tree-sitter"

## Local Bun scripts
alias now-timestamp='$HOME/utils/scripts/bun/timestamp.ts'
alias identity='$HOME/utils/scripts/bun/identity.ts'

## Easy life
alias àmajuscule='echo -n "À" | cb'
alias émajuscule='echo -n "É" | cb'
alias èmajuscule='echo -n "È" | cb'
alias êmajuscule='echo -n "Ê" | cb'
alias ëmajuscule='echo -n "Ë" | cb'
alias çmajuscule='echo -n "Ç" | cb'

## cheatsheets
# TODO from importme.bash_aliases.bash
alias cheat_fish_open='firefox https://cheatsheetshero.com/search?q=fish+shell'

## HELP / REMINDERS
# compatibility with from importme.bash_aliases.bash
# TODO
# set -l HELPERS_DIR $HOME/utils/scripts/bash_aliases/helpers/all.sh
# set -l HELPERS_DIR $HOME/utils/scripts/bash_aliases/helpers/_private.sh
# if test -e $HELPERS_DIR
    # bass source $HELPERS_DIR
# end

## tldr.sh
# Unfortunately, tldr node client does not work, so use python client instead
set -x TLDR_LANGUAGE "en"
set -x TLDR_PLATFORM "linux"
alias tldr="tldr-py"

## Games
# compatibility with from importme.bash_aliases.bash
set -l GAMES_ALIASES_DIR $HOME/utils/scripts/bash_aliases/games.sh
if test -e $GAMES_ALIASES_DIR
    bass source $GAMES_ALIASES_DIR
end
