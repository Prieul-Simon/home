# home

This repository contains my configuration files, my folder hierarchy I'm used to work with, and the programs and extensions I use on everyday usage.

## Autoinstall script

> [!NOTE]
> Execute from a tmp dir to avoid to put some files in unexpected locations if there is a bug in the script:
```sh
bash -c "$(curl https://raw.githubusercontent.com/Prieul-Simon/home/refs/heads/main/scripts/autoinstall/install.bash)"
```

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
