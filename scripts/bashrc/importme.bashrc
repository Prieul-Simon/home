#####################################################################################################################################################
# In ~/.bashrc, include this file with the following line:
# `source "$HOME/utils/scripts/bashrc/importme.bashrc"`
# 
# need to install and then symlink the folder containing all the .md files containing the cheatsheets:
# ```
# bun install
# ln -s /path/to/the/storage/dir/assets/cheatsheets bun/cheatsheets
# ```
#####################################################################################################################################################

# binaries
export PATH="/mnt/data/pbin/_all:$PATH"

# Load all scripts completions in 'sh' folder
for file in $HOME/utils/scripts/bashrc/sh/*.sh $HOME/utils/scripts/bashrc/sh/*.bash; do 
    if [ -f "$file" ]; then  
	    . "$file"
    fi 
done

# Git
source "$HOME/utils/scripts/bashrc/git/git-prompt.sh"
export GIT_PS1_SHOWDIRTYSTATE=1
PS1=$PS1'\[\e[91m\]$(__git_ps1 "(%s) ")\[\e[00m\]'
# PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '


# Git completion
source "$HOME/utils/scripts/bashrc/git/git-completion.bash"
