## WSL virtual partitions

On Windows side (only the first time):

```powershell
diskpart
create vdisk file="C:\Users\<user>\<windows_data_path>\vhdx\shared_data.vhdx" maximum=54272 type=expandable
exit
wsl --mount --vhd C:\Users\<user>\<windows_data_path>\vhdx\shared_data.vhdx --bare
```

Note: 54272 is 53GB


On Linux side:

```bash
lsblk                                   # identify it, e.g. /dev/sde (match the 53G size, no partitions)
sudo mkfs.ext4 /dev/<correct_device>    # use the right device, this erases it
```


On Windows side:

```powershell
wsl --mount --vhd C:\Users\<user>\<windows_data_path>\vhdx\shared_data.vhdx --name data
```


On Linux side:

```bash
ls -al /mnt/wsl/data/
```

You can now work with a partition for data, dev projects, etc. which can be shared between multiple distributions and can survive system reinstalls\
If done before autoinstall, it can be set as PART_DATA_PATH
