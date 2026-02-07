#####################################################################################################################################################
# In ~/.bashrc, include this file with the following line:
# `source "$HOME/utils/scripts/bashrc/importme.bashrc.bash"`
# 
# need to download and setup the .sh files for git prompt+completions and all other completions :
# ```
# cd $HOME/utils/scripts/bun/
# bun install
# ./setup-git.ts
# ./setup-completions.ts
# ```
#####################################################################################################################################################

# binaries
export PATH="/mnt/data/pbin/_all:$HOME/.local/bin:$PATH"

# Set some environment preferences
tabs 4

# Load all scripts completions in 'sh' & 'sh/manual' folder
for file in $HOME/utils/scripts/bashrc/sh/*.sh $HOME/utils/scripts/bashrc/sh/*.bash; do 
    if [ -f "$file" ]; then  
	    . "$file"
    fi 
done
for file in $HOME/utils/scripts/bashrc/sh/manual/*.sh $HOME/utils/scripts/bashrc/sh/manual/*.bash; do 
    if [ -f "$file" ]; then  
	    . "$file"
    fi 
done

# Git
source "$HOME/utils/scripts/bashrc/git/current/git-prompt.sh"
export GIT_PS1_SHOWDIRTYSTATE=1
PS1=$PS1'\[\e[91m\]$(__git_ps1 "(%s) ")\[\e[00m\]'
# PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '
# Git completion
source "$HOME/utils/scripts/bashrc/git/current/git-completion.bash"

# Others
# export CAPACITOR_ANDROID_STUDIO_PATH="/home/simon/programs/android-studio-2024/bin/studio.sh"
export EDITOR="nano" # `lf` need it
# export EDITOR="cosmic-edit 2>/dev/null" # `lf` need it

# zoxide. It should be at the very end of this file !
eval "$(zoxide init bash)"

