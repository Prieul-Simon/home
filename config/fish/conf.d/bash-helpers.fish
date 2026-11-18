status is-interactive; or return

## HELP / REMINDERS
# compatibility with from importme.bash_aliases.bash
set -la bash_functions help.git help.systemd help.net help.ip help.curl help.docker help.chown help.rabbit
set -la bash_functions help.tmux goto.tmux.cheat
set -la bash_functions help.python
set -la bash_functions help.complete help.grep help.find
set -la bash_functions help.disk_space help.battery help.battery.clipboard.acpi help.battery.clipboard.upower
if test -e "$HOME/utils/config/bash/bash_aliases/helpers/all.sh"
    for bash_function in $bash_functions
        function $bash_function --inherit-variable bash_function
            /usr/bin/bash -c 'source $HOME/utils/config/bash/bash_aliases/helpers/all.sh; '$bash_function
        end
    end
end
