need some symlinks (adapt paths if needed)

## Keyboard shortcuts

```sh
cd ~/.config/cosmic/com.system76.CosmicSettings.Shortcuts
mv v1 v1.bak # check no info needs to be ported to the git repo
ln -s ~/utils/config/cosmic/com.system76.CosmicSettings.Shortcuts/v1 .   # bind COSMIC conf directory from this git repo to the expected location
rm -r v1.bak
```
