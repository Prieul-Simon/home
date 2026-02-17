#!/bin/bash

SECONDS=0
echo 'Start autoinstall'
## TODO .lessht is created at root of home
## preconditions:
## Execute with bash (sh is not sufficient)
## installed packages: git, wget, curl

## 0)
# files / directories variables
read -p 'Please enter the partition data path (WITHOUT last slash character) (for instance /mnt/mypartdata or /home/bob/data): ' PART_DATA_PATH
if [ -z "$PART_DATA_PATH" ]; then
    echo 'Error: PART_DATA_PATH is empty'
    exit 1
fi
export PART_DATA_PATH
echo "the partition is: $PART_DATA_PATH"
mkdir --verbose --parents $PART_DATA_PATH/pbin/_all
mkdir --verbose --parents $PART_DATA_PATH/pdata
mkdir --verbose --parents $PART_DATA_PATH/assets/fonts
mkdir --verbose --parents $PART_DATA_PATH/assets/cheatsheets
# dir
echo ''
mkdir --verbose $HOME/tmp

## 1) Prepare git
echo ''
echo 'Preparing git...'
# it is ok, this .config is not symlinked, it contains a custom .gitignore which will point to $HOME/utils/config/git
mkdir --verbose $HOME/.config/git
touch $HOME/.config/git/config
git config --global include.path "$HOME/utils/config/git/.gitconfig" # does not exist yet but it does not matter
echo 'current git config list is:'
git config --list

## 2) apt upgrade & add gh
echo ''
echo 'apt upgrade...'
sudo sudo apt update && apt list --upgradable && sudo apt upgrade -y
echo ''
echo 'Installing gh through apt...'
sudo apt install --yes gh

## 3) Fetch this repo
echo ''
echo 'Fetching "home" repository...'
PART_DEV_PATH="$PART_DATA_PATH/dev"
mkdir --verbose --parents $PART_DEV_PATH
# gh repo clone Prieul-Simon/home home.git
git clone https://github.com/Prieul-Simon/home.git $PART_DEV_PATH"/home.git"
if [ ! -d "$PART_DEV_PATH/home.git/.git" ]; then
    echo 'Error: git "home" repository was not fetched at the correct location'
    exit 1
fi

## 4) Make symbolic links I'm used to
echo ''
echo 'Creating symlinks...'
mkdir --verbose $HOME/utils
ln -s --verbose $PART_DEV_PATH/home.git/config $HOME/utils/
ln -s --verbose $PART_DEV_PATH/home.git/scripts $HOME/utils/
mkdir --verbose $HOME/.config/wget
ln -s --verbose $HOME/utils/config/wget/wgetrc $HOME/.config/wget/wgetrc
mkdir --verbose $HOME/.config/nano
ln -s --verbose $HOME/utils/config/nano/.nanorc $HOME/.config/nano/nanorc

## 5) Configure git
echo ''
echo 'Configuring git...'
# nothing to do, the linking in utils/config was sufficient
echo 'current git config list is (after configuring):'
git config --list

## 6) Configure .bashrc
TO_BE_SOURCED='
################################################################
################################################################
# My custom modifications ($PATH must be set BEFORE)
export DATA_PATH="'$PART_DATA_PATH'"
export PATH="$DATA_PATH/pbin/_all:$HOME/.local/bin:$PATH"
source "$HOME/utils/scripts/bashrc/importme.bashrc.bash"

################################################################
################################################################
'
echo "$TO_BE_SOURCED" >> $HOME/.bashrc
echo 'source "$HOME/utils/scripts/bash_aliases/importme.bash_aliases.bash"' >> $HOME/.bash_aliases

## 7) bun
echo ''
echo 'Installing bun...'
curl -fsSL https://bun.sh/install | bash
source $HOME/.bashrc
# install some packages globally
# run in another subprocess for sourcing
bash $HOME/utils/scripts/autoinstall/02_install_bun_packages.bash

## 8) Install Node through nvm
echo ''
echo 'Installing nvm...'
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.4/install.sh | bash
# run in another subprocess for sourcing
bash $HOME/utils/scripts/autoinstall/03_install_node.bash

## 8.1) Install interactive stuff
echo ''
echo 'Installing utilities for interactive (fish and bash)...'
# need to launch it with bash and not fish !
bash $HOME/utils/scripts/autoinstall/03b_bun_setups.bash

## 9) Install fish
echo ''
echo 'Installing fish...'
ln -s --verbose $HOME/utils/config/fish $HOME/.config/fish
sudo apt install --yes fish
echo 'Installing starship...'
curl -sS https://starship.rs/install.sh | sh

## 10) Delegate to fish
echo ''
echo 'Will now delegate the next steps of the installation to fish shell and 04_install.fish ...'
fish $HOME/utils/scripts/autoinstall/04_install.fish

echo ''
duration=$SECONDS
echo "End of install.sh: took $((duration / 60)) minutes $((duration % 60)) seconds"
