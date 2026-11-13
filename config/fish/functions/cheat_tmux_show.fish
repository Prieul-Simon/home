function cheat_tmux_show --description 'Print help for tmux'
    set -l bold $(tput bold)
    set -l normal $(tput sgr0)

    echo "\
"$bold"General $normal
 > Ctrl-B            Prefix. Will be referenced as <prefix> or <pref>.
 > <pref> ?          List key bindings
 > <pref> r          Reload config
 > <pref> d          Detach
 > <pref> :          Enter command mode

"$bold"Sessions $normal
 > <pref> w          Open tree of sessions
 > <pref> s          Show all sessions
 > <pref> \$          Rename current session

"$bold"Windows $normal
 > <pref> c          Create a new window
 > <pref> ,          Rename current window
 > <pref> 5          Switch window by number
 > <pref> <          Move current window on the left
 > <pref> >          Move current window on the right
 > <pref> _          Split current pane on the bottom
 > <pref> %          Split current pane on the right

"$bold"::-plugin-manager $normal
 > <pref> I          Install plugins and refresh tmux env
 > <pref> U          Update plugins

"$bold"::-resurrect $normal
 > <pref> Ctrl-s     Save
 > <pref> Ctrl-r     Restore

"$bold"Plugins using fzf $normal
 > <pref> u          Open menu for (forked)tmux-fzf-url
 > <pref> Shift-F    Open menu for sainnhe/tmux-fzf
 > <pref> Shift-O    Open menu for omerxx/tmux-sessionx\
"
end
