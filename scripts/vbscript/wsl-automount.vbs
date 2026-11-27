' Mounts a VHD partition in WSL at startup, with a visible terminal
' Copy and paste this file into Windows
' Don't forget to change the path to the .vhdx file
Const VHD_PATH = "C:\Users\<user>\<windows_data_path>\vhdx\shared_data.vhdx"
Const PART_NAME = "data"
Set shell = CreateObject("WScript.Shell")
' Wrapped in cmd.exe /k => the window will stay opened
shell.Run "cmd.exe /k echo ============================================================================================ && echo Will automount VHDX file into WSL: " & VHD_PATH & " && echo ============================================================================================ && wsl.exe --mount --vhd """ & VHD_PATH & """ --name " & PART_NAME, 1, True
