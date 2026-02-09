need to include it to ~/.gitconfig :

```
mkdir ~/.config/git
touch ~/.config/git/config
git config --global include.path "~/utils/config/git/.gitconfig"
git config --list
```
(see https://stackoverflow.com/questions/1557183/include-import-a-file-in-gitconfig)
