# fish does not show the alias that is set unlike bash when typing `alias egrep`
# thus, create a function`showalias` for that
function showalias
    # bass source $NVM_DIR/nvm.sh --no-use ';' nvm $argv
    set -l query $argv
    echo "> (showalias): Running command 'alias | grep \"^alias $query\"'"
    # echo "> (showalias): Running command 'alias | rg \"^alias $query\"'"
    echo '> Results:'
    alias|grep "^alias $query"
    # alias|rg "^alias $query"
end
