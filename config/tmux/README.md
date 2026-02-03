need some symlinks (adapt paths if needed):
```
ln -s ~/utils/config/tmux/.tmux.conf /home/username/
ln -s /mnt/data/pbin/.tmux /home/username/.tmux
ln -s /mnt/data/pdata/tmux/resurrect resurrect-data
```

(Need for tmux-resurrect plugin to start once and let him create the systemd service before executing that ?) :
```
mkdir ~/.config/systemd/user/tmux.service.d
ln -s ~/utils/config/tmux/tmux.service.d/override.conf ~/.config/systemd/user/tmux.service.d/
```
