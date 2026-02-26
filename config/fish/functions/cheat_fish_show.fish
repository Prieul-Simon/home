function cheat_fish_show --description 'Print help for fish shell'
    echo "\
> Ctrl-A        Move cursor to the beginning of the line.
> Ctrl-E        Move cursor to the end of the line.
> Ctrl-U        Delete from cursor to the beginning of the line.
> Ctrl-R        (fzf) Select & Paste onto the command-line from command-history
> Ctrl-T        (fzf) Select & Paste onto the command-line from found files/directories
> Alt-C         (fzf) cd into selected directory
> Alt-S         sudo <Previous command in history>
> Ctrl-G        (fzf-git) Prefix for key bindings for git. Then ? for more help\
"
end