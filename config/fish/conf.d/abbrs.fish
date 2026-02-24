## Core utilities
abbr --add -- - 'cd -' # typing '-' will autocomplete to 'cd -'
abbr --add batplain 'bat --force-colorization --paging=never --style=plain'
abbr --add dysk "dysk --units=binary --all --cols +label --sort=filesystem-asc --filter='size > 0 & !type=tmpfs'"

## Git abbrs
abbr --add --position anywhere --set-cursor='%' -- gitcommit git\ commit\ -m\ \'\%\'
abbr --add --position anywhere --set-cursor='%' -- gcommit git\ commit\ -m\ \'\%\'
abbr --add gstatus git status
abbr --add gitstatus git status
abbr --add gitsiwtchbranch "git branch | fzf --preview 'git show --color=always {-1}' \
                 --bind 'enter:become(git checkout {-1})' \
                 --height 40% --layout reverse"

## I use apt so often that I want to shortcut the commands
abbr --add  apt-list-upgradable "sudo apt update && apt list --upgradable"
abbr --add  aptlistupgradable "sudo apt update && apt list --upgradable"
abbr --add apt-upgrade "sudo apt upgrade -y"
abbr --add aptupgrade "sudo apt upgrade -y"

## Often-used programs
abbr --add noderun 'node --run'
abbr --add explorer 'cosmic-files &>/dev/null .'
abbr --add pdfreader 'evince'
abbr --add ccurl "curl -i -w '\n\n~~> Time: %{time_total}s\n'"
