## Fish
# fish does not show the alias that is set unlike bash when typing `alias egrep`
# thus, create an abbr `showalias` for that
abbr --add showalias --set-cursor='%' -- 'alias | grep "^alias %"'

## Core utilities
abbr --add batplain 'bat --force-colorization --paging=never --style=plain'

## Git abbrs
abbr --add --position anywhere --set-cursor='%' -- gitcommit git\ commit\ -m\ \'\%\'

## I use apt so often that I want to shortcut the commands
abbr --add  "apt-list-upgradable" "sudo apt update && apt list --upgradable"
abbr --add "apt-upgrade" "sudo apt upgrade -y"

## Often-used programs
abbr --add noderun 'node --run'
abbr --add explorer 'cosmic-files &>/dev/null .'
abbr --add pdfreader 'evince'
abbr --add ccurl "curl -i -w '\n\n~~> Time: %{time_total}s\n'"
