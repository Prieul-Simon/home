#####################################################################################################################################################
# In ~/.bashrc, include this file with the following line:
# `source "$HOME/utils/scripts/bashrc/importme.bashrc"`
# 
# need to download and setup the .sh files for git prompt & git completions :
# ```
# cd $HOME/utils/scripts/bun/
# bun install
# ./setup-git.ts
# ```
#####################################################################################################################################################

# binaries
export PATH="/mnt/data/pbin/_all:$PATH"

# Set some environment preferences
tabs 4

# Load all scripts completions in 'sh' folder
for file in $HOME/utils/scripts/bashrc/sh/*.sh $HOME/utils/scripts/bashrc/sh/*.bash; do 
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
