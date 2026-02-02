GPT partition table

| Name  | File System | Label | Size      |
| ----- | ----------- | ----- | --------- |
| esp   | fat32       | ESP   | 1 GiB     |
| swap  | linux-swap  | -     | RAM size  |
| root  | ext4        | popos | 100 GiB   |
| var   | ext4        | var   | 20 GiB    |
| homes | ext4        | homes | 150 GiB   |
| recovery | fat32    | RECOVERY | 4.5 GiB   |
| data  | ext4        | Data Disk Part  | remaining |


Recovery: 
* https://www.zaccariotto.net/post/pop_os-recovery-partition/
* https://baez.link/add-recovery-to-your-pop-_os
* https://www.reddit.com/r/pop_os/comments/m6ljkq/i_have_no_recovery_partition/
