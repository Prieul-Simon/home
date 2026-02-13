#!/bin/env fish

## 9) bun
echo ''
echo 'Installing bun...'
cd $HOME/tmp
curl -fsSL https://bun.sh/install | bash
# install some packages globally
bun --global install --verbose \
    clipboard-cli \
    http-server \
    gnomon \
    pino-pretty \
    tree-sitter-cli \
    

## 10) tmux
echo ''
echo 'Preparing tmux...'
cd $HOME/utils/config/tmux
if test $PART_DATA_PATH -eq ""
    echo 'error: PART_DATA_PATH is empty'
    exit 1
end
mkdir --verbose $HOME/.config/tmux
ln -s --verbose $HOME/utils/config/tmux/.tmux.conf              $HOME/.config/tmux/tmux.conf        # bind tmux conf file from this git repo to the expected location
mkdir --verbose --parents $PART_DATA_PATH/pbin/.tmux/plugins
ln -s --verbose $PART_DATA_PATH/pbin/.tmux/plugins              $HOME/.config/tmux/plugins          # bind partition .tmux/plugins folder to the expected location
mkdir --verbose --parents $PART_DATA_PATH/pdata/tmux/resurrect
ln -s --verbose $PART_DATA_PATH/pdata/tmux/resurrect            resurrect-data                      # bind partition resurrect folder to the expected location
echo 'Installing tmux...'
sudo apt install --yes tmux
echo 'Overriding systemd tmux.service...'
mkdir --verbose --parents $HOME/.config/systemd/user/tmux.service.d
ln -s $HOME/utils/config/tmux/tmux.service.d/override.conf $HOME/.config/systemd/user/tmux.service.d/

## 11) Font
echo ''
echo 'Installing terminal font...'
mkdir --verbose --parents $PART_DATA_PATH/assets/fonts/IosevkaTerm
cd $PART_DATA_PATH/assets/fonts/IosevkaTerm
wget -O IosevkaTerm.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/IosevkaTerm.zip && unzip IosevkaTerm.zip && rm IosevkaTerm.zip
cd $HOME/.local/share/fonts
cp --verbose $PART_DATA_PATH/assets/fonts/IosevkaTerm/*.ttf .

## 12) Ghostty
echo ''
echo 'Installing ghostty...'
ln -s --verbose $HOME/utils/config/ghostty $HOME/.config/ghostty
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/mkasberg/ghostty-ubuntu/HEAD/install.sh)"

## 13: Core utilities
echo ''
echo 'Installing core utilities...'
## fd
mkdir --verbose --parents $PART_DATA_PATH/pbin/fd
cd $PART_DATA_PATH/pbin/fd
wget -O fd.tar.gz https://github.com/sharkdp/fd/releases/download/v10.3.0/fd-v10.3.0-x86_64-unknown-linux-gnu.tar.gz
tar xvf fd.tar.gz
ln -s --verbose fd-v10.3.0-x86_64-unknown-linux-gnu current
ln -s --verbose $PART_DATA_PATH/pbin/fd/current/fd $PART_DATA_PATH/pbin/_all/
## fzf
mkdir --verbose --parents $PART_DATA_PATH/pbin/fzf/0.67.0
cd $PART_DATA_PATH/pbin/fzf
wget -O fzf.tar.gz https://github.com/junegunn/fzf/releases/download/v0.67.0/fzf-0.67.0-linux_amd64.tar.gz
tar xvf fd.tar.gz --directory 0.67.0
ln -s --verbose 0.67.0 current
ln -s --verbose $PART_DATA_PATH/pbin/fzf/current/fzf $PART_DATA_PATH/pbin/_all/
## zoxide
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
## eza
install-eza
## ripgrep
mkdir --verbose --parents $PART_DATA_PATH/pbin/ripgrep
cd $PART_DATA_PATH/pbin/ripgrep
wget -O ripgrep.tar.gz https://github.com/BurntSushi/ripgrep/releases/download/15.1.0/ripgrep-15.1.0-x86_64-unknown-linux-musl.tar.gz
tar xvf ripgrep.tar.gz
ln -s --verbose ripgrep-15.1.0-x86_64-unknown-linux-musl current
ln -s --verbose $PART_DATA_PATH/pbin/ripgrep/current/rg $PART_DATA_PATH/pbin/_all/
## bat
sudo apt install --yes bat
## yazi
mkdir --verbose --parents $PART_DATA_PATH/pbin/yazi
cd $PART_DATA_PATH/pbin/yazi
wget -O yazi.zip https://github.com/sxyazi/yazi/releases/download/v26.1.22/yazi-x86_64-unknown-linux-gnu.zip
unzip yazi.zip 
ln -s --verbose yazi-x86_64-unknown-linux-gnu current
ln -s --verbose $PART_DATA_PATH/pbin/yazi/current/yazi $PART_DATA_PATH/pbin/_all/
## dysk
mkdir --verbose --parents $PART_DATA_PATH/pbin/dysk/dysk_3.6.0
cd $PART_DATA_PATH/pbin/dysk/dysk_3.6.0
wget -O dysk.zip  https://dystroy.org/dysk/download/dysk_3.6.0.zip
unzip dysk.zip
cd $PART_DATA_PATH/pbin/dysk
ln -s --verbose dysk_3.6.0 current
ln -s --verbose $PART_DATA_PATH/pbin/dysk/current/build/x86_64-unknown-linux-gnu/dysk $PART_DATA_PATH/pbin/_all/

## 14) add apt packages
sudo apt install --yes \
    colorized-logs \
    libnotify-bin \
    python3-venv \
    python3-pip \
    cmatrix \
    gparted \
    btop \
    
## 15) Node through nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.4/install.sh | bash

## 16) tldr-py
mkdir --verbose --parents $PART_DATA_PATH/pbin/tldr-py
cd $PART_DATA_PATH/pbin/tldr-py
python3 -m venv ./
./bin/pip install tldr
ln -s --verbose $PART_DATA_PATH/pbin/tldr-py/bin/tldr $PART_DATA_PATH/pbin/_all/

## 17) neovim TODO

## 18) Fastfetch
cd $HOME/tmp
ln -s --verbose $HOME/utils/config/fastfetch $HOME/.config/fastfetch
wget -O fastfetch.deb https://github.com/fastfetch-cli/fastfetch/releases/download/2.58.0/fastfetch-linux-amd64.deb
chmod +x fastfetch.deb
sudo apt install --yes ./fastfetch.deb

## 19) Install interactive stuff
# For fish
cd $HOME/utils/scripts/bun
bun install --verbose
./setup-completions.ts
# For bash
./setup-git.ts # Will install git prompt and git completions
# + TODO cheatsheets

## 20) End
echo ''
echo 'trying running fastfetch: '
nvm use default
fastfetch
echo ''
echo "End of 02_install.fish ! Don't forget to test if ghostty, tmux (launch it and install plugins), bash & fish shells work as expected !"

### Function for installing eza
### See https://github.com/eza-community/eza/blob/main/INSTALL.md#manual-linux
function install-eza
    cd $HOME/tmp
    wget -c https://github.com/eza-community/eza/releases/latest/download/eza_x86_64-unknown-linux-gnu.tar.gz -O - | tar xz
    sudo chmod +x eza
    sudo chown root:root eza
    sudo mv --verbose eza /usr/local/bin/eza
end
