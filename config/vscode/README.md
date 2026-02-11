need some symlinks (adapt paths if needed)

## User directory

If `~/.config/Code` does not exist yet
```sh
mkdir ~/.config/Code
ln -s ~/utils/config/vscode/User ~/.config/Code/ # bind VSCode conf directory from this git repo to the expected location
```

If `~/.config/Code` already exists (if Code was already launched)
```sh
mv ~/.config/Code/User ~/.config/Code/User.bak
rm ~/.config/Code/User.bak/chatLanguageModels.json # check no info needs to be ported to the git repo
rm ~/.config/Code/User.bak/keybindings.json        # check no info needs to be ported to the git repo
rm ~/.config/Code/User.bak/settings.json           # check no info needs to be ported to the git repo
mv ~/.config/Code/User.bak/* ~/utils/config/vscode/User/
rmdir ~/.config/Code/User.bak                      # should now be empty
ln -s ~/utils/config/vscode/User ~/.config/Code/   # bind VSCode conf directory from this git repo to the expected location
```
