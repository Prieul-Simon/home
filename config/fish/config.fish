#####################################################################################################################################################
# Create a symlink to this repository from the expected location:
# `ln -s $HOME/utils/config/fish $HOME/.config/fish`
# 
# need to download and setup the .fish files for completions :
# ```
# cd $HOME/utils/scripts/bun/
# bun install
# ./setup-completions.ts
# ```
#####################################################################################################################################################

################################################################
################################################################
### My custom modifications

################################################################
################################################################

## Interactive only
if status is-interactive
    # Commands to run in interactive sessions can go here

    ## Completions
    # system completions
    set fish_complete_path /usr/share/fish/completions $fish_complete_path
    # manual (i.e. not version-controlled) completions
    set fish_complete_path $HOME/.config/fish/completions/manual $fish_complete_path

    ## Set some environment preferences
    # tabs 4 # TODO it was in my bash config, is it needed in fish ?

    ## power commands
    # ripgrep aka rg
    set -gx RIPGREP_CONFIG_PATH $HOME/utils/config/ripgrep/ripgreprc

    # fzf
    fzf --fish | source
    # set -gx FZF_DEFAULT_COMMAND 'fd --type file --follow --hidden --exclude .git --color=always'
    # set -gx FZF_DEFAULT_OPTS "--ansi"
    # set -gx FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
    set -gx FZF_CTRL_T_OPTS "
        --walker-skip .git,node_modules,target,dist
        --preview 'bat -n --color=always {}'
        --bind 'ctrl-/:change-preview-window(down|hidden|)'
    "
    # Print tree structure in the preview window
    set -gx FZF_ALT_C_OPTS "
        --walker-skip .git,node_modules,target,dist
        --preview 'tree -C {}'
    "

    # zoxide. It should be at the very end of this file !
    set -x _ZO_DATA_DIR $XDG_DATA_HOME/zoxide # directory in which the database is stored
    set -x _ZO_ECHO '1' # z will print the matched directory before navigating to it
    # set -x _ZO_EXCLUDE_DIRS '' # separated by ':'
    # set -x _ZO_FZF_OPTS '' # Custom options to pass to fzf during interactive selection
    set -x _ZO_MAXAGE 200000 # aging algorithm, which limits the maximum number of entries in the databas
    # set -x _ZO_RESOLVE_SYMLINKS '1' # if '1', z will resolve symlinks before adding directories to the database
    zoxide init --cmd cd fish | source

    ## End of this file : Starship prompt (https://starship.rs/)
    set -x STARSHIP_CONFIG "$HOME/utils/config/starship/starship.toml"
    starship init fish | source
end
