-----------------------
*Mon Mar 21 12:00:54 2022*

[test](#test)

-----------------------
*Mon Mar 21 12:07:07 2022*

| a   | b   | c   |
|:---:|:---:|:---:|
| zz  | bb  | xx  |

```python
for i in range(a):
  print(i)

```


-----------------------
*Mon Mar 21 12:18:41 2022*

_

-----------------------
*Mon Mar 21 12:26:36 2022*

kia~

-----------------------
*Mon Mar 21 18:08:30 2022*

之前瞎折腾重装ubuntu时把EFI系统分区清空了，导致windows也无法启动，也没有环境做启动盘。现在两个系统总算装回来了，想要在u盘上做个备用环境，主要运行分区软件和iso烧录软件，以前用过 windows PE ，第三方的，有恶意脚本，所以想去体验一下官方的版本，跟着教程操作半天，结果发现说PE不支持GUI程序，好吧。。。不过好在那个分区软件有个系统偏移的功能，把刚刚装好的windows拷贝到u盘里了，希望能一切顺利。

哦，对了，之前听人说过可以把iso直接dd到u盘上启动，根本不行好吗，不知道这是不是和UEFI有关，我的设备似乎太老了不支持UEFI(?)

好了，先这样吧，之前的工程已经停滞好久了，赶紧把系统配置好继续开工了。


-----------------------
*Thu Mar 24 10:26:00 2022*

写了个vim插件，颜色值调节

```vim
" hsv.s + 10%
:K color s+10


```

-----------------------
*Fri Mar 25 12:11:58 2022*

/system/usr/keychars/Generic.kcm

-----------------------
*Fri Mar 25 16:22:24 2022*

 [copilot](https://copilot.github.com/#faqs) AI coding?

-----------------------
*Mon Mar 28 21:39:58 2022*

还是标准库的`argpaser`好用

-----------------------
*Tue Mar 29 05:21:59 2022*

 `etc/rc.local  -rwxr-xr-x`


```sh
sudo systemctl enable rc-local.service
```
-----------------------
*Tue Mar 29 11:07:09 2022*

```sh
export ALL_PROXY=socks5://127.0.0.1:1080

export http_proxy="http://usrname:passwrd@host:port"
export https_proxy="http://usrname:passwrd@host:port"

```


