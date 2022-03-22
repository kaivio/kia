# vim note

1. [概述](#概述)
   * [模式](#模式)
   * [选项 (set)](#选项-(set))
   * [变量 (let)](#变量-(let))
     * [类型](#类型)
     * [运算](#运算)
   * [寄存器](#寄存器)
2. [语法](#语法)
   * [命令与动作](#命令与动作)
   * [逻辑判断](#逻辑判断)
   * [循环](#循环)
   * [函数](#函数)
     * [自动函数](#自动函数)
   * [内置函数](#内置函数)
3. [键映射](#键映射)
   * [特殊键](#特殊键)
   * [属性参数](#属性参数)
   * [Operator Pending](#operator-pending)
4. [命令注册](#命令注册)
   * [属性(选项)](#属性(选项))
   * [参数引用](#参数引用)
5. [自动命令](#自动命令)
6. [异步](#异步)

## 概述
### 模式
`n(normal)`, `i(insert)` ,`c(command)`, `v(visual, s(select))`

### 选项 (set)
用 `set` 命令设置/列出选项值，大部分支持缩写。
- rtp(runtimepath) 插件搜索目录
  - `/plugin/*.vim`  初始化加载
  - `/autoload/foo.vim`  函数`foo#*`被调用时加载
  - `/after` (?)
- ft(filetype)
- paste, nopaste

### 变量 (let)
用 `let`, `unlet` 命令定义，删除变量
- g: 全局
- l: 局部
- s: 脚本文件
- a: 参数
- v: 内置
- &  选项
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
- `python3` 执行python代码
- `normal` `python3` 命令参数是语法糖，不是字符串，不能加引号，需要动态植入变量需要配合 `execute` 使用

在下一行插入 hello:
```vim
execute "normal ohello"
```
- `!`调用外部命令，带上范围参数可将范围绑定到标准输入输出流

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
- 用`a:`前缀 访问实参
- 用`...`声明可变参数，从 `a:1`开始，`a:0`是长度，`a:000`是作为列表
- 默认返回 0
- 属性
  - abort 出错终止
  - range 接收 `a:firstline` `a:lastline`，缺省则自动迭代调用
  - dict  要求用字典键调用 (?)
  - closure 闭包
- 用 function(name) 取函数地址
- 用 call(ref,[...])  从地址调用函数
- 支持lambda `let f = {x -> x +1 }`

#### 自动函数
- 位于`autoload`目录
- 函数名以`basename#funcname` 格式，可以小写
- 首次被调用时才加载

#### 内置函数
- `:help function-list`
- `expand()` 获取*当前状态*变量
  - `%` 当前编辑文件
  - `<sfile>` 当前脚本文件
  - 当前函数名，所在行号，光标指向的文件名
  - `:p` 后缀修饰表示绝对路径
  - `:h` 后缀修饰表示只保留头部(多指目录)

- omap()
- umap, mapclear
### 特殊键
用 `<>` 括起来: `<CR>`
- 常规 Space, TAB, CR, BAR(|), lt, rt,  Bang(!)
BS(🔙), DEL, INS, F1...F12
- 状态 C-?, S-?, A-?
- 字符编码 Char-?
- 特殊
  - Leader
  - SID
  - Plug 用于给映射标识

### 属性参数
用 `<>` 括起来，在 `{lhs}`之前，用空格分隔 `<buffer>`
- buffer  仅作用于
- nowait  歧义不等待
- unique  确保唯一
- silent  不回显
- script  限定右参数 `{rhs}` 不会再与脚本外部的映射相互作用
- expr  `{rhs}` 视为表达式求值，`@={rhs}<CR>`隐式声明

### Operator Pending
Vim 普通模式下的许多命令都是“操作符+文本对象”范式。比如最常见的 `y` `d` `c` 就
是操作符，当你按下这几个键之一后，就进入了所谓的“命令后缀”模式，vim 会等待你输
入后续的操作目标即文本对象。文本对象包括以下两大类：

1. 使用移动命令后光标扫描过的文本区域，即光标停靠点与原来光标位置之间的区域。
2. 预定义的文本对象，常用的有：
  - `ap` `ip` 一个段落，段落由空行分隔，`ap` 包括下一个空行，`ip` 不包括。
  - `a(` `i(` 或 `a)` `i)` 一个小括号，`a-` 表示包括括号本身，`i-` 只是括号内
    部部分。
  - `a[` `a]` `a{` `a}`，`i[` `i]` `i{` `i}` 与小括号类似。
  - `a"` `a'` ，`i"` `i'` 与小括号类似，但是由引号括起的部分。

## 命令注册
```vim
command[!] [属性] {name} {rep}
```

- 定义命令名只能大写开头
- ! 表示覆盖之前的定义

### 属性(选项)
- `-buffer` 作用于缓存区
- `-bang` 允许 `!` 修饰
- `-register` 第一个参数允许寄存器
- `-bar` 允许用 | 分隔，接续另一个命令。
- `-nargs=0` 设置参数数量(常量, ?,+,*)
- `-range=%` 接收范围参数 
- `-range=N` 接收单数字参数
- `-count=N` 在前缀或参数表接收数字参数
- `-addr=?` 地址的对象类别 (?)
  - lines 当前缓冲的文本行，默认
  - arguments 启动参数表
  - buffers 指所有打开过的 buffer
  - loaded_buffers 仅指当前加载的 buffer，在某个窗口中显示的 buffer
  - windows 所有窗口列表的范围，仅限当前标签页。
  - tabs 取所有标签页范围
- `-complete=?` 补全方法
  - file
  - option
  - help
  - shellcmd
  - tag
  - filetype
  - `custom,{func}`
    ```vim
    function func(ArgLead,CmdLine,CursorPos)
      return "item1\nitem2\n..."
    endfunction
    ```
### 参数引用
用 `<参数名>` 引用参数
- line1, line2 范围地址
- count 
- bang 感叹号标记
- reg 寄存器
- args 参 数 表
- q-args "参 数 表"
- f-args "参", "数", "表"


## 自动命令
```vim
autocmd {event} {pat} {cmd}
autocmd BuffEntry *.vim
autocmd FileType vim 
```

- 事件列表 `:help autocmd-events`

## 异步
- `:help job`

## python 接口
- `:help python-vim`
