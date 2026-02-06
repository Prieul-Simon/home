#####################################################################################################################################################
# In ~/.bash_aliases, include this file with the following line:
# `source "$HOME/utils/scripts/bash_aliases/importme.bash_aliases"`
# 
# need to install and then symlink the folder containing all the .md files containing the cheatsheets:
# ```
# cd $HOME/utils/scripts/bun/
# bun install
# ln -s /mnt/data/assets/cheatsheets cheatsheets
# ```
#####################################################################################################################################################

source "${BASH_SOURCE%/*}/create_alias.sh"

# Improve even more ls & other aliases
alias ll='ls -alFh'
alias grep='grep --color=always'
alias fgrep='fgrep --color=always'
alias egrep='egrep --color=always'

#alias noderun='node --run'
alias pdfreader='evince'
alias ccurl="curl -i -w '\n\n~~> Time: %{time_total}s\n'"

# I use apt so often that I want to shortcut the commands
__simon_create_alias "apt-list-upgradable" "sudo apt update && apt list --upgradable"
__simon_create_alias "apt-upgrade" "sudo apt upgrade -y"

# Utilities
alias python='python3'
alias fake-mail='python -m smtpd -n -c DebuggingServer localhost:25'

# Better commands
function recursive-grep() {
    echo "> grep -RHIn --exclude-dir={dist,node_modules,.git,var,.local} --color=always \""$@"\" | cut -c 1-400"
    grep -RHIn --exclude-dir={dist,node_modules,.git,var} --color=always "$@" | cut -c 1-400
    return 0
}
function find-then-grep() {
    echo " > find -name "$1" -exec grep -HIn \"$2\" {} +"
    echo ""
    find -name "$1" -exec grep --color=always -HIn "$2" {} +
    return 0
}

# Use npmjs.com packages installed globally with Bun
alias cb='bun run --bun --no-install clipboard'
alias bun_httpserver='bun run --no-install http-server' # Need Node.js/nvm as it does not work with Bun runtime
alias bun_gnomon='bun run --bun --no-install gnomon'
alias prettylog="bun run --bun --no-install pino-pretty"
export __SIMON_TLDR_NODE_CLIENT="/mnt/data/dev/_ext/tldr-node-client/bin/tldr"
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
function cheatsheet() {
    ## TODO script for argument completion (because it will be difficult to guess `cheatsheet git-tricks`` for example)
    [ -z $1 ] && echo "Argument missing: name of the cheatsheet";
    bun run $HOME/utils/scripts/bun/cheatsheets.ts --name ${1-"<missing cheatsheet argument>"};
}

# HELP / REMINDERS
source "${BASH_SOURCE%/*}/helpers/all.sh"

# tldr.sh
# Unfortunately, tldr node client does not work, so use python client instead
export TLDR_LANGUAGE="en"
alias tldr="tldr-py"

# Games
if [ -f "${BASH_SOURCE%/*}/games.sh" ]; then  
    source "${BASH_SOURCE%/*}/games.sh"
fi 
