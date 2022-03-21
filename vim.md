# vim note

## 概述
### 模式
n(normal), i(insert) c(command), v(visual, s(select))

### 选项 (set)
- rtp(runtimepath) 插件搜索目录
  - `/plugin/*.vim`  初始化加载
  - `/autoload/foo.vim`  函数`foo#*`被调用时加载
  - `/after` (?)
- ft(filetype)
- paste, nopaste

### 变量 (let)
- g: 全局
- l: 局部
- s: 脚本文件
- a: 参数
- v: 内置
- &  选项
let, unlet
#### 类型
- 字符串 `"hello"` `'world'` 用`.`连接。单引号不能`\`转义，其内的`''`转为`'`
- 整数 123
- 小数 1.23
  -  四舍五入 round(1.23) -> 1.0
- 列表 `[1,2,3]`
  - add(list,val)
  - remove(list,val)
  - len(list)
  - sort(list)
  - range(start,end,seq)
- 字典 `{'x': 1, 'y': 2, 'z': 3,}` 
  - 支持下标语法和点语法索引
  - keys(dict), values(dict), items(dict)

#### 运算
- +-*/% += -= ...

### 寄存器


## 语法
### 命令与动作
- 脚本或`:`模式输入每一行称为命令
- 用 `\` 在开头表示延续上一行 
- 用 `|` 在单行拼接多条命令
- 在普通模式下的输入称为动作
- `execute` 配合变量动态执行命令
- `normal` 模拟普通模式下的动作

在下一行插入 helll:
```vim
execute "normal ohello"
```


### 逻辑判断
```vim
if 1 < 2
  echo 'yes'
endif
```
### 循环
```vim
for v in list
  echo v
endfor

for [key,val] in items(dict)
  echo key val
endfor

l:i = 0
while i < 5
  let i += 1
endwhile
```
- 支持 continue, break
### 函数
```vim

function[!] 函数名(参数列表) 附加属性
  函数体
  return 0
endfunction

```
- 定义函数名只能大写开头
- ! 表示覆盖之前的定义
- 默认返回 0
- 属性
  - abort 出错终止
  - range 接收 `a:firstline` `a:lastline`，缺省则自动迭代调用
  - dict  要求用字典键调用 (?)
  - closure 闭包




## 
