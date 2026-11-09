# home

This repository contains my configuration files, my folder hierarchy I'm used to work with, and the programs and extensions I use on everyday usage.

## Autoinstall script

> [!NOTE]
> Execute from a tmp dir to avoid to put some files in unexpected locations if there is a bug in the script:
```sh
bash -c "$(curl https://raw.githubusercontent.com/Prieul-Simon/home/refs/heads/main/scripts/autoinstall/install.bash)"
```

## Forced to work with Windows ?

* Setup nerd font: go to https://www.nerdfonts.com/font-downloads and download your favorite one (for instance IosevkaTerm Nerd Font). Then install it with Configuration Panel on Windows
* Install ghostty on Windows : https://github.com/shiweis/ghostty-windows
* Copy / Paste `softwares/windows/ghostty-windows/config.ghostty` into `C:\Users\<user>\AppData\Local\ghostty\config.ghostty`. Edit it with the correct values
* Setup WSL (https://learn.microsoft.com/en-us/windows/wsl/setup/environment) :
    * `wsl --list --online`
    * `wsl --install --no-distribution`
    * `wsl --list`
    * `wsl --distribution Ubuntu-26.04`
    * apt update, upgrade and install packages (unzip...) if needed
    * Launch autoinstall script
    * Do not forget the workarounds at then end (edition of 00-variables.fish, first launch of tmux, etc.)

## Manual

Start by the following steps (if autoinstall was used, it is already done):

```
mkdir $DATA_PATH/dev
cd $DATA_PATH/dev
gh repo clone Prieul-Simon/home home.git
mkdir ~/utils
cd ~/utils
ln -s $DATA_PATH/dev/home.git/config config
ln -s $DATA_PATH/dev/home.git/scripts scripts
```

Then
* fish: follow the instructions in `config.fish`
* bash: follow the instructions in `importme.bashrc.bash` and `importme.bash_aliases.bash`
