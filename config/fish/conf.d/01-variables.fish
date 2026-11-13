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
if test "$DATA_PATH" = ""
    echo '[WARNING]: DATA_PATH is empty. Please copy/paste 00-datapath-variable.fish.sample to 00-datapath-variable.fish and set its real value'
end

## binaries in PATH
set PATH $HOME/.local/bin $PATH
set PATH $DATA_PATH/pbin/_all $PATH

# bun
set -x BUN_INSTALL $XDG_DATA_HOME/bun
set PATH $BUN_INSTALL/bin $PATH

# nvm
set -x NVM_DIR $XDG_CONFIG_HOME/nvm
# npm
set -gx NPM_CONFIG_USERCONFIG $HOME/utils/config/npm/.npmrc

## Node.js
## https://nodejs.org/api/repl.html#environment-variable-options
set -x NODE_REPL_HISTORY $XDG_STATE_HOME/.node_repl_history
## Python
set -x PYTHON_HISTORY $XDG_STATE_HOME/.python_history # for python >= 3.13 only
## wget
## https://bug-wget.gnu.narkive.com/BFRYDBtI/wishlist-configure-wget-hsts-by-environment-variable
set -x WGETRC $XDG_CONFIG_HOME/wget/wgetrc

## dotnet (which I don't use directly, it is used by another program)
set -x DOTNET_CLI_HOME $XDG_DATA_HOME/dotnet
# GnuPG
set -x GNUPGHOME $XDG_DATA_HOME/gnupg
# Docker
set -gx DOCKER_CONFIG $XDG_CONFIG_HOME/docker

## Others
# set -x CAPACITOR_ANDROID_STUDIO_PATH "/home/simon/programs/android-studio-2024/bin/studio.sh"
set -x EDITOR nano
