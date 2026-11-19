# Windows

## clipboard / clipboardy

clipboard (and its dependency clipboardy) is installed globally with bun. It may fail on WSL due to file permission. Do:
```
cd ~/.local/share/bun/install/cache/clipboardy@<version>/fallbacks/windows
chmod +x clipboard_*.exe
```

## Tips

* https://www.justgeek.fr/activer-pave-numerique-demarrage-pc-windows-120474/