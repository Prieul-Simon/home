status is-interactive; or return

## Source common helpers with bash shell
bass source $HOME/utils/config/bash/bash_aliases/core/all.sh

## Improve even more ls & other aliases
# Now silently use eza instead of ls
alias l el
alias la ela
alias ls el
alias ll ellla
alias grep 'grep --color=always'
alias fgrep 'fgrep --color=always'
alias egrep 'egrep --color=always'
alias bat batcat

## Utilities
alias boo='ghostty +boo'
# alias python='python3'
alias fake-mail='python3 -m smtpd -n -c DebuggingServer localhost:25'

## Better commands
# TODO from importme.bash_aliases.bash

## Use npmjs.com packages installed globally with Bun
alias cb='bun run --bun --no-install clipboard'
alias bun_httpserver='bun run --no-install http-server'
alias bun_gnomon='bun run --bun --no-install gnomon'
alias prettylog="bun run --bun --no-install pino-pretty"
# set __SIMON_TLDR_NODE_CLIENT "$DATA_PATH/dev/_ext/tldr-node-client/bin/tldr"
# alias tldr-bun="bun run --bun $__SIMON_TLDR_NODE_CLIENT"
# alias tldr-node="$__SIMON_TLDR_NODE_CLIENT"
alias tree-sitter="bun run --bun --no-install tree-sitter"
alias leaf="bun run --bun --no-install leaf"

## Local Bun scripts
alias now-timestamp='$HOME/utils/scripts/bun/timestamp.ts'
alias identity='$HOME/utils/scripts/bun/identity.ts'
alias uppercase='$HOME/utils/scripts/bun/uppercase.ts'

## Easy life
alias majuscule_cb='uppercase | xsel --clipboard --input'
alias àmajuscule='echo -n "à" | majuscule_cb'
alias émajuscule='echo -n "é" | majuscule_cb'
alias èmajuscule='echo -n "è" | majuscule_cb'
alias êmajuscule='echo -n "ê" | majuscule_cb'
alias ëmajuscule='echo -n "ë" | majuscule_cb'
alias çmajuscule='echo -n "ç" | majuscule_cb'

## cheatsheets
alias ?:nopop="cheat_fish_show"
alias ?tmux:nopop="cheat_tmux_show"
if test -n "$TMUX_PANE"
    # tmux context
    function __simon_tmux_pop
        tmux display-popup -w 80% -h 80% fish -i -c '$argv 2>&1 | tr -d "\017" | bat --paging=auto --decorations=never' $argv
    end
    alias ?="__simon_tmux_pop ?:nopop"
    alias ?tmux="__simon_tmux_pop ?tmux:nopop"
else
    alias ?="?:nopop"
    alias ?tmux="?tmux:nopop"
end
alias cheat_fish_open='xdg-open https://cheatsheetshero.com/search?q=fish+shell'
# TODO from importme.bash_aliases.bash

## tldr.sh
# Unfortunately, tldr node client does not work, so use python client instead
set -x TLDR_LANGUAGE "en"
set -x TLDR_PLATFORM "linux"
# alias tldr="tldr-py"

## Games
# compatibility with from importme.bash_aliases.bash
set -l games_aliases_dir $HOME/utils/config/bash/bash_aliases/games.sh
if test -e $games_aliases_dir
    bass source $games_aliases_dir
end
