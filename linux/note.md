
+ grep 对 unicode 的支持存在兼容性问题


+ 盒盖不挂起
```
sudo vim /etc/systemd/logind.conf
HandleLidSwitch=ignore
sudo service systemd-logind restart
```
