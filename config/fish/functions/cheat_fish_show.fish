function cheat_fish_show --description 'Print help for fish shell'
    set -l bold $(tput bold)
    set -l normal $(tput sgr0)

    echo "\
"$bold"General $normal
 > Ctrl-A            Move cursor to the beginning of the line.
 > Ctrl-E            Move cursor to the end of the line.
 > Ctrl-U            Delete from cursor to the beginning of the line.
 > Shift-delete      Delete from history the current command-line.
 > Alt-S             sudo <Previous command in history> (equivalent to `sudo !!` in bash)

"$bold"fzf $normal
 > Ctrl-R            (fzf) Select & Paste onto the command-line from command-history
 > Ctrl-T            (fzf) Select & Paste onto the command-line from found files/directories
 > Alt-C             (fzf) cd into selected directory
 > Ctrl-G            (fzf-git) Prefix for key bindings for git. Then ? for more help
"
end