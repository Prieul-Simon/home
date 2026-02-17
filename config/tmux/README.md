need some symlinks (adapt paths if needed):
```
ln -s ~/utils/config/tmux/.tmux.conf    ~/.config/tmux/tmux.conf        # bind tmux conf file from this git repo to the expected location
ln -s $DATA_PATH/pbin/.tmux/plugins     ~/.config/tmux/plugins          # bind $DATA_PATH partition .tmux/plugins folder to the expected location
ln -s $DATA_PATH/pdata/tmux/resurrect   resurrect-data                  # bind $DATA_PATH partition resurrect folder to the expected location
```

(Need for tmux-resurrect plugin to start once and let him create the systemd service before executing that ?) :
```
mkdir ~/.config/systemd/user/tmux.service.d
ln -s ~/utils/config/tmux/tmux.service.d/override.conf ~/.config/systemd/user/tmux.service.d/
```
