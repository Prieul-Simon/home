# home

This repository contains my configuration files, my folder hierarchy I'm used to work with, and the programs and extensions I use on everyday usage.

## Autoinstall script

> [!NOTE]
> Execute from a tmp dir to avoid to put some files in unexpected locations if there is a bug in the script:
```sh
bash -c "$(curl https://raw.githubusercontent.com/Prieul-Simon/home/refs/heads/main/scripts/autoinstall/install.bash)"
```

## Forced to work with Windows ?

* (Optional: Setup nerd font: go to https://www.nerdfonts.com/font-downloads and download your favorite one (for instance IosevkaTerm Nerd Font). Then install it with Configuration Panel on Windows)
* (Optional: Install ghostty on Windows : https://github.com/shiweis/ghostty-windows)
* (Optional: Copy / Paste `softwares/windows/ghostty-windows/config.ghostty` into `C:\Users\<user>\AppData\Local\ghostty\config.ghostty`. Edit it with the correct values)
* Setup WSL (https://learn.microsoft.com/en-us/windows/wsl/setup/environment) :
    * `wsl --list --online`
    * `wsl --install --no-distribution`
    * `wsl --list`
    * `wsl --distribution Ubuntu-26.04`
    * apt update, upgrade and install packages (unzip...) if needed
    * (Optional): Setup disk partitions. See [partitions.md](softwares/windows/partitions.md)
    * Launch autoinstall script
    * Do not forget the workarounds at the end (edition of 00-datapath-variable.fish, first launch of tmux, etc.)

In order to make some other things to work, you may need to:

* `sudo apt install xdg-open` (for making `fzf-url` work)

### Ghostty

Alternatively, you can still install the font and ghostty on Linux, and then create a Windows shortcut with this target:

`"C:\Program Files\WSL\wslg.exe" -d Ubuntu-26.04 --cd "~" -- env GDK_BACKEND=x11 XCURSOR_SIZE=24 /usr/bin/ghostty --gtk-single-instance=true`

### VS Code

* Make sure WSL extension (`ms-vscode-remote.remote-wsl`) is installed
* Open the command palette and "WSL: Connect to WSL using Distro..."  => the first time, VS Code will install a server in WSL
* You may need to install extensions on the WSL server side
* Once setup, you can save the workspace (locally on Windows with `Show local`) with naming pattern `wsl-<name>.code-workspace`

## Miscellaneous

### Local git-ignore

If using different versions of softwares on different machines (e.g. btop 1.3.0 and 1.4.6), some configuration files may have different format. If you want to ignore your local modifications, but still keep version control on other machines, use this fish abbreviation:
`git-local-ignore config/btop/btop.conf`
