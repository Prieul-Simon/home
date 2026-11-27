## WSL virtual partitions

### Create a VHDX file

On Windows side (only the first time):

```powershell
diskpart
create vdisk file="C:\Users\<user>\<windows_data_path>\vhdx\shared_data.vhdx" maximum=54272 type=expandable
exit
wsl --mount --vhd C:\Users\<user>\<windows_data_path>\vhdx\shared_data.vhdx --bare
```

Note: 54272 is 53GB

### Format the virtual partition

On Linux side:

```bash
lsblk                                   # identify it, e.g. /dev/sde (match the 53G size, no partitions)
sudo mkfs.ext4 /dev/<correct_device>    # use the right device, this erases it
```

### Mount the partition for all WSL Linux distributions

On Windows side:

```powershell
wsl --mount --vhd C:\Users\<user>\<windows_data_path>\vhdx\shared_data.vhdx --name data
```

> [!NOTE]
> Everytime WSL is shutdown (i.e. everytime `wsl --shutdown` is called manually or Windows System is rebooted), the VHDX file needs to be mounted again. That's why in the next section, we'll try to automate this

On Linux side:

```bash
ls -al /mnt/wsl/data/
```

You can now work with a partition for data, dev projects, etc. which can be shared between multiple distributions and can survive system reinstalls\
If done before autoinstall, it can be set as PART_DATA_PATH

### Automount the partition on Windows startup

Copy and paste `scripts/vbscript/wsl-automount.vbs` from this repository to Windows filesystem and replace the paths with the correct ones.\
Then create a Windows shortcut in `C:\Users\<user>\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup` with the `.vbs` script as target

