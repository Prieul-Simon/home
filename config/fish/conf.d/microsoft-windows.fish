## Windows specific stuff

function __inject_windows_paths
    # set -q WSL_DISTRO_NAME; or return
    set -l cache $XDG_CACHE_HOME/wsl-winpath
    # Entries WSL injects: Windows drives and the WSL GPU libs
    set -l injected (string match -r '^(/mnt/[a-z]/.*|/usr/lib/wsl/lib)$' -- $PATH)

    if test (count $injected) -gt 0
        # Vanilla shell: PATH is good, so record the injected entries
        # mkdir -p $XDG_CACHE_HOME
        printf '%s\n' $injected > $cache
    else if test -s $cache
        # tmux (or any bare environment): restore them, after the Linux paths
        for p in (cat $cache)
            test -d $p; and fish_add_path --append --path $p
        end
    end
end

if grep -qi microsoft /proc/version 2>/dev/null

    ## Debug values
    set -gx __SIMON_IS_WSL 'yes'
    if status is-interactive
        set -gx __SIMON_IS_WSL_INTERACTIVE 'yes'
    end

    ## for xdg-open in a tmux context
    # set -gx BROWSER '/mnt/c/Windows/System32/cmd.exe /c start'
    set -gx BROWSER '/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe -NoProfile -Command Start-Process'

    ## for a consistent $PATH
    __inject_windows_paths
end
