# Improve even more ls & other aliases
alias ll="ls -alFh --color=always"
alias la='ls -A --color=always'
alias l='ls -CF --color=always'
alias grep='grep --color=always'
alias fgrep='fgrep --color=always'
alias egrep='egrep --color=always'
alias bat='batcat'
abbr --add batplain 'bat --force-colorization --paging=never --style=plain'
alias lf='lfcd'
abbr --add --position anywhere --set-cursor='%' -- gitcommit git\ commit\ -m\ \'\%\'

abbr --add noderun 'node --run'
abbr --add pdfreader 'evince'
abbr --add ccurl "curl -i -w '\n\n~~> Time: %{time_total}s\n'"

# I use apt so often that I want to shortcut the commands
abbr --add  "apt-list-upgradable" "sudo apt update && apt list --upgradable"
abbr --add "apt-upgrade" "sudo apt upgrade -y"

# Utilities
alias boo='ghostty +boo'
alias python='python3'
alias fake-mail='python -m smtpd -n -c DebuggingServer localhost:25'

# Better commands
# TODO from importme.bash_aliases.bash

# Use npmjs.com packages installed globally with Bun
alias cb='bun run --bun --no-install clipboard'
alias bun_httpserver='bun run --no-install http-server' # Need Node.js/nvm as it does not work with Bun runtime
alias bun_gnomon='bun run --bun --no-install gnomon'
alias prettylog="bun run --bun --no-install pino-pretty"
set __SIMON_TLDR_NODE_CLIENT "/mnt/data/dev/_ext/tldr-node-client/bin/tldr"
alias tldr-bun="bun run --bun $__SIMON_TLDR_NODE_CLIENT"
alias tldr-node="$__SIMON_TLDR_NODE_CLIENT"

# Local Bun scripts
alias now-timestamp='$HOME/utils/scripts/bun/timestamp.ts'

# Easy life
alias àmajuscule='echo -n "À" | cb'
alias émajuscule='echo -n "É" | cb'
alias èmajuscule='echo -n "È" | cb'
alias êmajuscule='echo -n "Ê" | cb'
alias ëmajuscule='echo -n "Ë" | cb'
alias çmajuscule='echo -n "Ç" | cb'

# cheatsheets
# TODO from importme.bash_aliases.bash

# HELP / REMINDERS
# TODO from importme.bash_aliases.bash

# tldr.sh
# Unfortunately, tldr node client does not work, so use python client instead
set -x TLDR_LANGUAGE "en"
alias tldr="tldr-py"

# Games
# TODO from importme.bash_aliases.bash
