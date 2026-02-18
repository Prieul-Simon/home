## Fish configuration
## https://fishshell.com/docs/current/language.html#special-variables
set -gx SHELL /usr/bin/fish
set -g fish_autosuggestion_enabled 1
# set -g fish_color_autosuggestion
# set -U fish_greeting

## XDG spec
## https://wiki.archlinux.org/title/XDG_Base_Directory
set -gx XDG_CONFIG_HOME $HOME/.config
set -gx XDG_CACHE_HOME $HOME/.cache
set -gx XDG_DATA_HOME $HOME/.local/share
set -gx XDG_STATE_HOME $HOME/.local/state

## Needed variables for my custom environment
set -gx DATA_PATH /mnt/data

## binaries in PATH
set PATH $HOME/.local/bin $PATH
# FIXME here as a workaround, all alternatives of the PART_DATA are statically set, even though some of them does not exist on the current machine
set PATH /mnt-mydata/pbin/_all $PATH
set PATH /mnt/mydata/pbin/_all $PATH
set PATH $DATA_PATH/pbin/_all $PATH

# bun
set -x BUN_INSTALL $XDG_DATA_HOME/bun
set PATH $BUN_INSTALL/bin $PATH

# nvm
set -x NVM_DIR $XDG_CONFIG_HOME/nvm

## Node.js
## https://nodejs.org/api/repl.html#repl_environment_variable_options
set -x NODE_REPL_HISTORY $XDG_STATE_HOME/.node_repl_history
## Python
set -x PYTHON_HISTORY $XDG_STATE_HOME/.python_history # for python >= 3.13 only
## wget
## https://bug-wget.gnu.narkive.com/BFRYDBtI/wishlist-configure-wget-hsts-by-environment-variable
set -x WGETRC $XDG_CONFIG_HOME/wget/wgetrc

## Others
# set -x CAPACITOR_ANDROID_STUDIO_PATH "/home/simon/programs/android-studio-2024/bin/studio.sh"
set -x EDITOR nano