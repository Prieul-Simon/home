#!/bin/env fish

## 11) tmux
echo ''
echo 'Preparing tmux...'
if test $PART_DATA_PATH = ""
    echo 'error: PART_DATA_PATH is empty'
    exit 1
end
mkdir --verbose $HOME/.config/tmux
ln -s --verbose $HOME/utils/config/tmux/.tmux.conf              $HOME/.config/tmux/tmux.conf # bind tmux conf file from this git repo to the expected location
mkdir --verbose --parents $PART_DATA_PATH/pbin/.tmux/plugins
ln -s --verbose $PART_DATA_PATH/pbin/.tmux/plugins              $HOME/.config/tmux/plugins # bind partition .tmux/plugins folder to the expected location
mkdir --verbose --parents $PART_DATA_PATH/pdata/tmux/resurrect
ln -s --verbose $PART_DATA_PATH/pdata/tmux/resurrect            $HOME/utils/config/tmux/resurrect-data # bind partition resurrect folder to the expected location
echo 'Installing tmux...'
sudo apt install --yes tmux
echo 'Overriding systemd tmux.service...'
mkdir --verbose --parents $HOME/.config/systemd/user/tmux.service.d
ln -s $HOME/utils/config/tmux/tmux.service.d/override.conf $HOME/.config/systemd/user/tmux.service.d/
echo 'Install Tmux Plugin Manager'
git clone https://github.com/tmux-plugins/tpm $HOME/.config/tmux/plugins/tpm

## 12) Font
echo ''
echo 'Installing terminal font...'
mkdir --verbose --parents $PART_DATA_PATH/assets/fonts/IosevkaTerm
wget -O IosevkaTerm.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/IosevkaTerm.zip
unzip IosevkaTerm.zip -d $PART_DATA_PATH/assets/fonts/IosevkaTerm
rm --verbose IosevkaTerm.zip
mkdir --verbose --parents $HOME/.local/share/fonts/
cp --verbose $PART_DATA_PATH/assets/fonts/IosevkaTerm/*.ttf $HOME/.local/share/fonts/

## 13) Ghostty
echo ''
echo 'Installing ghostty...'
ln -s --verbose $HOME/utils/config/ghostty $HOME/.config/
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/mkasberg/ghostty-ubuntu/HEAD/install.sh)"

## 14) Core utilities
echo ''
echo 'Installing core utilities...'
## fd
mkdir --verbose --parents $PART_DATA_PATH/pbin/fd
wget -O fd.tar.gz https://github.com/sharkdp/fd/releases/download/v10.3.0/fd-v10.3.0-x86_64-unknown-linux-gnu.tar.gz
tar xf fd.tar.gz --directory $PART_DATA_PATH/pbin/fd
ln -s --verbose $PART_DATA_PATH/pbin/fd/fd-v10.3.0-x86_64-unknown-linux-gnu $PART_DATA_PATH/pbin/fd/current
ln -s --verbose $PART_DATA_PATH/pbin/fd/current/fd $PART_DATA_PATH/pbin/_all/
ln -s --verbose $PART_DATA_PATH/pbin/fd/current/autocomplete/fd.fish $HOME/utils/config/fish/completions/manual/ # bind fd completions from source
## fzf
mkdir --verbose --parents $PART_DATA_PATH/pbin/fzf/0.67.0
wget -O fzf.tar.gz https://github.com/junegunn/fzf/releases/download/v0.67.0/fzf-0.67.0-linux_amd64.tar.gz
tar xf fzf.tar.gz --directory $PART_DATA_PATH/pbin/fzf/0.67.0
ln -s --verbose $PART_DATA_PATH/pbin/fzf/0.67.0 $PART_DATA_PATH/pbin/fzf/current
ln -s --verbose $PART_DATA_PATH/pbin/fzf/current/fzf $PART_DATA_PATH/pbin/_all/
## zoxide
mkdir --verbose --parents $PART_DATA_PATH/pdata/zoxide/.local/share/zoxide
ln -s --verbose $PART_DATA_PATH/pdata/zoxide/.local/share/zoxide $HOME/.local/share/zoxide
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
## eza
### Function for installing eza
### See https://github.com/eza-community/eza/blob/main/INSTALL.md#manual-linux
function install-eza
    wget -c https://github.com/eza-community/eza/releases/latest/download/eza_x86_64-unknown-linux-gnu.tar.gz -O - | tar xz
    sudo chmod +x eza
    sudo chown root:root eza
    sudo mv --verbose eza /usr/local/bin/eza
end
install-eza
## ripgrep
mkdir --verbose --parents $PART_DATA_PATH/pbin/ripgrep
wget -O ripgrep.tar.gz https://github.com/BurntSushi/ripgrep/releases/download/15.1.0/ripgrep-15.1.0-x86_64-unknown-linux-musl.tar.gz
tar xf ripgrep.tar.gz --directory $PART_DATA_PATH/pbin/ripgrep
ln -s --verbose $PART_DATA_PATH/pbin/ripgrep/ripgrep-15.1.0-x86_64-unknown-linux-musl $PART_DATA_PATH/pbin/ripgrep/current
ln -s --verbose $PART_DATA_PATH/pbin/ripgrep/current/rg $PART_DATA_PATH/pbin/_all/
ln -s --verbose $PART_DATA_PATH/pbin/ripgrep/current/complete/rg.fish $HOME/utils/config/fish/completions/manual/ # bind ripgrep completions from source
## bat
sudo apt install --yes bat
ln -s --verbose $HOME/utils/config/bat $HOME/.config/ # bind bat conf directory from this git repo to the expected location
## yazi
mkdir --verbose --parents $PART_DATA_PATH/pbin/yazi
wget -O yazi.zip https://github.com/sxyazi/yazi/releases/download/v26.1.22/yazi-x86_64-unknown-linux-gnu.zip
unzip yazi.zip -d $PART_DATA_PATH/pbin/yazi
ln -s --verbose $PART_DATA_PATH/pbin/yazi/yazi-x86_64-unknown-linux-gnu $PART_DATA_PATH/pbin/yazi/current
ln -s --verbose $PART_DATA_PATH/pbin/yazi/current/yazi $PART_DATA_PATH/pbin/_all/
ln -s --verbose $HOME/utils/config/yazi $HOME/.config/ # bind yazi conf directory from this git repo to the expected location
ln -s --verbose $PART_DATA_PATH/pbin/yazi/current/completions/yazi.fish $HOME/utils/config/fish/completions/manual/ # bind yazi completions from source
## dysk
mkdir --verbose --parents $PART_DATA_PATH/pbin/dysk/dysk_3.6.0
wget -O dysk.zip  https://dystroy.org/dysk/download/dysk_3.6.0.zip
unzip dysk.zip -d $PART_DATA_PATH/pbin/dysk/dysk_3.6.0
ln -s --verbose $PART_DATA_PATH/pbin/dysk/dysk_3.6.0 $PART_DATA_PATH/pbin/dysk/current
ln -s --verbose $PART_DATA_PATH/pbin/dysk/current/build/x86_64-unknown-linux-gnu/dysk $PART_DATA_PATH/pbin/_all/
ln -s --verbose $PART_DATA_PATH/pbin/dysk/current/build/completion/dysk.fish $HOME/utils/config/fish/completions/manual/ # bind dysk completions from source

## 15) add apt packages
echo ''
echo 'Installing utilities from apt...'
sudo apt install --yes \
    colorized-logs \
    libnotify-bin \
    python3-venv \
    python3-pip \
    cmatrix \
    gparted \
    btop \
    fortune-mod \
    cowsay \
    lolcat \
    

# Patch gparted desktop
mkdir --verbose --parents $HOME/.local/share/applications/
mkdir --verbose --parents $HOME/.local/state/gparted-wrapper
touch $HOME/.local/state/gparted-wrapper/log.log
ln -s --verbose $HOME/utils/scripts/launch-app/gparted-wrapper/gparted.desktop  $HOME/.local/share/applications/gparted.desktop
    
## 16) tldr-py
echo ''
echo 'Installing tldr (Python Client)...'
mkdir --verbose --parents $PART_DATA_PATH/pdata/.tldr-py
ln -s --verbose $PART_DATA_PATH/pdata/.tldr-py $HOME/.cache/tldr
mkdir --verbose --parents $PART_DATA_PATH/pbin/tldr-py
python3 -m venv $PART_DATA_PATH/pbin/tldr-py/
$PART_DATA_PATH/pbin/tldr-py/bin/pip install tldr
ln -s --verbose $PART_DATA_PATH/pbin/tldr-py/bin/tldr $PART_DATA_PATH/pbin/_all/

## 17) neovim
echo ''
echo 'Preparing neovim (linking my LazyVim configuration)...'
ln -s --verbose $HOME/utils/config/nvim $HOME/.config/
ln -s --verbose $HOME/utils/scripts/bash/luajitversion $PART_DATA_PATH/pbin/_all/
echo 'Installing neovim...'
set -l NEOVIM_VERSION 'v0.11.6'
mkdir --verbose --parents $PART_DATA_PATH/pbin/neovim/$NEOVIM_VERSION
wget -O nvim.tar.gz https://github.com/neovim/neovim/releases/download/$NEOVIM_VERSION/nvim-linux-x86_64.tar.gz
tar xf nvim.tar.gz --strip-components=1 --directory $PART_DATA_PATH/pbin/neovim/$NEOVIM_VERSION
ln -s --verbose $PART_DATA_PATH/pbin/neovim/$NEOVIM_VERSION $PART_DATA_PATH/pbin/neovim/current
ln -s --verbose $PART_DATA_PATH/pbin/neovim/current/bin/nvim $PART_DATA_PATH/pbin/_all/

## 18) Fastfetch
echo ''
echo 'Installing fastfetch..'
ln -s --verbose $HOME/utils/config/fastfetch $HOME/.config/
wget -O fastfetch.deb https://github.com/fastfetch-cli/fastfetch/releases/download/2.58.0/fastfetch-linux-amd64.deb
chmod +x fastfetch.deb
sudo apt install --yes ./fastfetch.deb

## 20) COSMIC
if test $XDG_SESSION_DESKTOP = "COSMIC"
    echo ''
    echo 'COMSIC detected! Trying to link my shared COSMIC configuration files: '
    for dir_name in 'com.system76.CosmicSettings.Shortcuts' 'com.system76.CosmicPanel.Dock' 'com.system76.CosmicPanel.Panel'
        rm -rf --verbose $HOME/.config/cosmic/$dir_name/v1
        # TODO when v2 etc. will exist, adapt this script
        # here I try to be careful with the use of 'rm'
        rm -rf --verbose $HOME/.config/cosmic/$dir_name
        # bind COSMIC conf directory from this git repo to the expected location
        ln -s --verbose $HOME/utils/config/cosmic/$dir_name $HOME/.config/cosmic/
    end
    echo 'COMSIC configured, you may need to relogin to avoid graphical issues'
end

## 21) End
echo ''
echo 'End of installation: trying running fastfetch: '
nvm use default
fastfetch
echo ''
echo "End of 02_install.fish !"
echo "Don't forget to test if ghostty, tmux, bash & fish shells work as expected"
echo "You should also check the current folder and remove some files if they were not properly deleted"
echo "For authenticating to GitHub, run 'gh auth'"
echo "For initializing tmux, launch it once and install plugins (<Prefix>+Ctrl-I)"
echo "For initializing LazyVim, launch nvim at least once"
echo ''
