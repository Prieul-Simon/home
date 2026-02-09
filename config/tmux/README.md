need some symlinks (adapt paths if needed):
```
ln -s ~/utils/config/tmux/.tmux.conf    ~/.config/tmux/tmux.conf        # bind tmux conf file from this git repo to the expected location
ln -s /mnt/data/pbin/.tmux/plugins      ~/.config/tmux/plugins          # bind /mnt/data partition .tmux/plugins folder to the expected location
ln -s /mnt/data/pdata/tmux/resurrect    resurrect-data                  # bind /mnt/data partition resurrect folder to the expected location
```

(Need for tmux-resurrect plugin to start once and let him create the systemd service before executing that ?) :
```
mkdir ~/.config/systemd/user/tmux.service.d
ln -s ~/utils/config/tmux/tmux.service.d/override.conf ~/.config/systemd/user/tmux.service.d/
```
