# myhelp
linux_shell_自定义命令管理助手

## 使用场景
* myhelp

    自定义命令入口, 使用格式等

* myhelp cmd

    显示自定义的命令
* myhelp note

    显示通用笔记
* myhelp local

    显示本地笔记
* myhelp sync

    同步通用笔记

## 如何使用

1. 在home目录下创建myhelp.sh
2. 给文件添加执行权限: chmod +x ~/myhelp.sh
3. 打开您的Shell终端(zsh,bash等)的配置文件, 如 ~/.bashrc 或 ~/.zshrc 等, 在文件末尾添加命令别名myhelp, 添加代码如下:

   > \#=====myhelp=====
   >
   > alias myhelp='sh ~/myhelp.sh'
   >
   > \#=====myhelp_cmd=====
   >

4. 以后将您自定义的命令都添加在 #=====myhelp_cmd===== 行之后, 该行为匹配标记, 配置文件代码请参考 .bashrc 文件范例

    > ...     \# .bashrc 原有代码
    >
    >#=====myhelp=====
    >
    >alias myhelp='sh ~/myhelp.sh'
    >
    >#=====myhelp_cmd=====
    >
    > \# ==下面为添加的自定义命令==
    >
    ># [apache]
    >alias apache_start='sudo apachectl start'
    >alias apache_stop='sudo apachectl stop'
    >alias apache_restart='sudo apachectl restart'
    >
    ># [web]
    >alias dj='python manage.py '
    >alias cd_www='cd /var/www'
    >alias env_start='source ./env/bin/activate'
    >
    ># [supervisor]
    >alias supervisor_stop='supervisorctl shutdown'



## 文件说明

|文件|说明|
|  ----  | ----  |
|myhelp.sh|脚本文件|
|myhelp_cfg.txt|脚本配置文件|
|myhelp_note.txt|通用笔记, 使用update命令会被覆盖|
|myhelp_local.txt|本地笔记, 只针对本地有效 |


## 配置文件myhelp_cfg.txt说明

> zsh_path=$root_path"/.zshrc"   \# zsh配置文件路径
>
>bash_path=$root_path"/.bashrc"  \# bash配置文件路径
>
>note_path=$root_path"/myhelp_note.txt"   # 通用笔记路径
>
>local_path=$HOME"/myhelp_local.txt"   # 本地笔记路径
>
> \# 远程同步笔记URL, 通常存放在外网, 用于存放个人常用的命令或者辅助性的内容, 没有具体格式要求, 可多端(多服务器)下同步
>
>sync_url="http://xxx.com/myhelp_sync.txt"
>

## 命令展示行数

脚本中的数字为展示的行数, 您可以调整数字的大小, 用以显示更多的自定义命令


    if [ -f "$zsh_path" ];then
      grep -A 200  =====myhelp_cmd===== $zsh_path
    else
      grep -A 100  =====myhelp_cmd===== $bash_path
    fi