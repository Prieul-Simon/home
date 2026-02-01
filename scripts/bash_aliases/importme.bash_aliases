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

#alias noderun='node --run'
alias pdfreader='evince'
alias ccurl="curl -i -w '\n\n~~> Time: %{time_total}s\n'"

# Use npmjs.com packages installed globally with Bun
alias cb='bun run --bun --no-install clipboard'
alias bun_httpserver='bun run --no-install http-server' # Need Node.js/nvm as it does not work with Bun runtime
alias bun_gnomon='bun run --bun --no-install gnomon'
alias prettylog="bun run --bun --no-install pino-pretty"

# cheatsheets
function cheatsheet() {
    ## TODO script for argument completion (because it will be difficult to guess `cheatsheet git-tricks`` for example)
    [ -z $1 ] && echo "Argument missing: name of the cheatsheet";
    bun run $HOME/utils/scripts/bun/cheatsheets.ts --name ${1-"<missing cheatsheet argument>"};
}
