## Windows specific stuff
if grep -qi microsoft /proc/version 2>/dev/null
    set -gx __SIMON_IS_WSL 'yes'
    # set -gx BROWSER '/mnt/c/Windows/System32/cmd.exe /c start'
    set -gx BROWSER '/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe -NoProfile -Command Start-Process'
end