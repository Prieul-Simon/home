function cheat_fish_show --description 'Print help for fish shell'
    echo "\
> Ctrl-A        Move cursor to the beginning of the line.
> Ctrl-E        Move cursor to the end of the line.
> Ctrl-U        Delete from cursor to the beginning of the line.
> Ctrl-R        (fzf) Paste into current command through history
> Ctrl-T        (fzf) Paste into current command
> Alt-C         (fzf) cd into selected directory
> Alt-S         sudo <Previous command in history>"
end