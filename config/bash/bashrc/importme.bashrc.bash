#####################################################################################################################################################
# In ~/.bashrc, include this file with the following line:
# `source "$HOME/utils/config/bash/bashrc/importme.bashrc.bash"`
# 
# need to download and setup the .sh files for git prompt+completions and all other completions :
# ```
# cd $HOME/utils/scripts/bun/
# bun install
# ./setup-git.ts
# ./setup-completions.ts
# ```
#####################################################################################################################################################

# Welcome message
echo "You are currently in bash shell"

## XDG spec
## https://wiki.archlinux.org/title/XDG_Base_Directory
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# Set some environment preferences
tabs 4

# Load all scripts completions in 'sh' & 'sh/manual' folder
for file in $HOME/utils/config/bash/bashrc/sh/*.sh $HOME/utils/config/bash/bashrc/sh/*.bash; do 
    if [ -f "$file" ]; then  
	    . "$file"
    fi 
done
for file in $HOME/utils/config/bash/bashrc/sh/manual/*.sh $HOME/utils/config/bash/bashrc/sh/manual/*.bash; do 
    if [ -f "$file" ]; then  
	    . "$file"
    fi 
done

# Git
source "$HOME/utils/config/bash/bashrc/git/current/git-prompt.sh"
export GIT_PS1_SHOWDIRTYSTATE=1
PS1=$PS1'\[\e[91m\]$(__git_ps1 "(%s) ")\[\e[00m\]'
# PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '
# Git completion
source "$HOME/utils/config/bash/bashrc/git/current/git-completion.bash"

# npm
export NPM_CONFIG_USERCONFIG="$HOME/utils/config/npm/.npmrc"

# Node.js
# https://nodejs.org/api/repl.html#repl_environment_variable_options
export NODE_REPL_HISTORY="$XDG_STATE_HOME/.node_repl_history"
# Python
export PYTHON_HISTORY="$XDG_STATE_HOME/.python_history" # for python >= 3.13 only
# wget
# https://bug-wget.gnu.narkive.com/BFRYDBtI/wishlist-configure-wget-hsts-by-environment-variable
export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"
# dotnet (which I don't use directly, it is used by another program)
export DOTNET_CLI_HOME="$XDG_DATA_HOME/dotnet"
# GnuPG
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
# Docker
export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker

# Others
# export CAPACITOR_ANDROID_STUDIO_PATH="/home/simon/programs/android-studio-2024/bin/studio.sh"
export EDITOR="nano"

# fzf
eval "$(fzf --bash)"
# fzf-git
source "$HOME/utils/config/fzf-git/fzf-git.sh"
# zoxide. It should be at the very end of this file !
eval "$(zoxide init bash)"

