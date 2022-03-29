

+ 在`~/.ssh/authorized_keys`存放写入公钥(.pub)
+ 密钥对文件的权限必须是 `rw- --- ---`
+ `ssh-keygen -t rsa -b 2048 -C "any comment"` 生成密钥对
+ `~/.config` 格式参考
```conf
host mydev
  hostname 192.168.203.173
  user root
  PreferredAuthentications publickey
  IdentityFile ~/.ssh/mydev
```
+ `/etc/sshd.conf` 参考
```conf
#TODO
```
