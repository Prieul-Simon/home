if status is-interactive
    # Commands to run in interactive sessions can go here
    # End of this file : Starship prompt (https://starship.rs/)
    set -x STARSHIP_CONFIG "$HOME/utils/config/starship/starship.toml"
    starship init fish | source
end

################################################################
################################################################
### My custom modifications

## binaries
set PATH /mnt/data/pbin/_all:$HOME/.local/bin $PATH

## Completions
# system completions
set fish_complete_path /usr/share/fish/completions $fish_complete_path
# manual (i.e. not version-controlled) completions
set fish_complete_path $HOME/.config/fish/completions/manual $fish_complete_path

## Set some environment preferences
# tabs 4 # TODO it was in my bash config, is it needed in fish ?

## power commands
# fzf
fzf --fish | source
# zoxide. It should be at the very end of this file !
zoxide init --cmd cd fish | source

################################################################
################################################################

# bun
set -x BUN_INSTALL $HOME/.bun
set PATH $BUN_INSTALL/bin $PATH

# nvm
set -x NVM_DIR $HOME/.nvm