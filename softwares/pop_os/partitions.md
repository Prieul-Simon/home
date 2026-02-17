## GPT partition table

| Part      | Name         | File System | Mount point | Label           | Size      |
| --------- | ------------ | ----------- | ----------- | --------------- | --------- |
| 1         | ESP          | fat32       | /boot/efi   | ESP             | 1.0 GiB   |
| 2         | recovery     | fat32       | /recovery   | RECOVERY        | 4.0 GiB   |
| 3         | root         | ext4        | /           | popos           | 100 GiB   |
| 4         | var          | ext4        | /var        | var             | 20 GiB    |
| 5         | homes        | ext4        | /home       | homes           | 150 GiB   |
| 6         | swap         | linux-swap  | -           | -               | RAM size  |
| 7         | data         | ext4        | /mnt/data   | Data Disk Part  | remaining |


Recovery: 
* https://www.zaccariotto.net/post/pop_os-recovery-partition/
* https://baez.link/add-recovery-to-your-pop-_os
* https://www.reddit.com/r/pop_os/comments/m6ljkq/i_have_no_recovery_partition/

## /etc/fstab

```
# Begin manual adds
UUID=[...]                        /mnt/data        ext4        defaults,noatime,nofail,discard            0 2
PARTUUID=[...]                    /recovery        vfat        umask=0077                                 0 0
# End   manual adds
```
