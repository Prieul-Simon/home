function cheat_fish_show --description 'Print help for fish shell'
    echo "\
> Ctrl-A        Move cursor to the beginning of the line.
> Ctrl-E        Move cursor to the end of the line.
> Ctrl-U        Delete from cursor to the beginning of the line.
> Ctrl-R        (fzf) Complet current command through history
> Ctrl-T        (fzf) Complete current command"
end