#!/bin/sh

# https://codywilliamson.com/blog/eza-technical-reference/
# Complete alias reference with primary flags
# 
# Alias	    Purpose	                            Key Flags
# 
# el 	    Grid view 	                        --icons --group-directories-first
# ela 	    Grid view with hidden files 	    -a --icons --group-directories-first
# ell 	    Minimal list 	                    -l --no-permissions --no-user --time-style=relative
# ella 	    Minimal list with hidden files 	    -la --no-permissions --no-user --time-style=relative
# elll 	    Full list with headers 	            -l --header --time-style=long-iso
# ellla 	Full list with all files 	        -la --header --time-style=long-iso
# elt 	    Sort by modified time 	            -l --sort=modified
# els 	    Sort by size 	                    -l --sort=size
# elg 	    List with Git status 	            -l --git
# t 	    Tree view (2 levels) 	            --tree -L 2
# tt 	    Tree view (4 levels) 	            --tree -L 4
# eld 	    Directories only 	                --only-dirs
# elf 	    Files only 	                        --only-files 





## Grid and Minimal Views
# Grid views
alias el='eza --icons --group-directories-first'
alias ela='eza -a --icons --group-directories-first'

# Minimal list views (size, relative date, name)
alias ell='eza -l --icons --group-directories-first --no-permissions --no-user --time-style=relative'
alias ella='eza -la --icons --group-directories-first --no-permissions --no-user --time-style=relative'


## Full Detail and Sorted Views
# Full list views (permissions, user, long timestamps)
alias elll='eza -l --header --icons --group-directories-first --time-style=long-iso'
alias ellla='eza -la --header --icons --group-directories-first --time-style=long-iso'

# Sorted views
alias elt='eza -l --icons --group-directories-first --no-permissions --no-user --time-style=relative --sort=modified'
alias els='eza -l --icons --group-directories-first --no-permissions --no-user --time-style=relative --sort=size'


## Git Integration and Tree Views
# Git status views
alias elg='eza -l --icons --git --group-directories-first --no-permissions --no-user --time-style=relative'
alias elga='eza -la --icons --git --group-directories-first --no-permissions --no-user --time-style=relative'

# Tree views
alias t='eza --tree -L 2 --icons --group-directories-first'
alias tt='eza --tree -L 4 --icons --group-directories-first'


## Filter Aliases
# Filters
alias eld='eza --icons --group-directories-first --only-dirs'
alias elf='eza --icons --group-directories-first --only-files'
