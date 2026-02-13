# home

This repository contains my configuration files, my folder hierarchy I'm used to work with, and the programs and extensions I use on everyday usage.

Start by the following steps:

```
mkdir /mnt/data/dev
cd /mnt/data/dev
gh repo clone Prieul-Simon/home home.git
mkdir ~/utils
cd ~/utils
ln -s /mnt/data/dev/home.git/config config
ln -s /mnt/data/dev/home.git/scripts scripts
```

Then
* fish: follow the instructions in `config.fish`
* bash: follow the instructions in `importme.bashrc.bash` and `importme.bash_aliases.bash`

## Experimental
### Autoinstall script

```sh
sh -c "$(curl https://raw.githubusercontent.com/Prieul-Simon/home/refs/heads/main/scripts/autoinstall/install.sh)"
```


