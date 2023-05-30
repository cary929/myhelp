#!/bin/bash

clear
version="1.0"
cfg_path=$HOME"/myhelp_cfg.txt"

if [ -f "$cfg_path" ];then
  source $cfg_path
else
cat <<End-of-message
首次使用, 请编辑配置文件: ${cfg_path}
End-of-message

cat  > ${cfg_path} <<End-of-message
zsh_path=$HOME/.zshrc
bash_path=$HOME/.bashrc
note_path=$HOME/myhelp_note.txt
local_path=$HOME/myhelp_local.txt
sync_url="http://xxx.com/myhelp.txt"  # 远端同步URL,  请替换xxx.com为您的域名
End-of-message
exit;
fi

cat <<End-of-message
---------------------------------------------------
	服务器命令行管理助手 ${version}
  https://github.com/cary929/myhelp
---------------------------------------------------
	命令:  #myhelp [参数]
	参数:
	  cmd          显示个人添加的自定义命令
	  note         显示笔记, 可从远端获取
	  local        显示本地笔记, 只在本机使用, 不同步
	  sync         获取远端帮助文件内容, 并覆盖本地的文件
---------------------------------------------------
End-of-message

for var in $*
do
    case "$var" in
      "note")
          if [ -f "${note_path}" ];then
            cat $note_path
          else
cat > ${note_path} <<End-of-message
#=====myhelp=====
End-of-message
cat <<End-of-message
已创建帮助文件模板, 您可以编辑使用 , 也可以使用下面命令来获取远端的帮助文件:
  #myhelp sync
End-of-message
          fi
          exit;;
      "local")
          if [ -f "${local_path}" ];then
            cat $local_path
          else
cat > ${local_path} <<End-of-message
#=====mylocal=====
End-of-message

cat <<End-of-message
已经为您添加本地帮助文件： ${local_path}
End-of-message
          fi
          exit;;
      "cmd")
          if [ -f "$zsh_path" ];then
            grep -A 200  =====myhelp_cmd===== $zsh_path
          else
            grep -A 100  =====myhelp_cmd===== $bash_path
          fi
          exit;;
      "sync" )
          if [ -z "$sync_url" ];then
            echo 'sync url is empty.'
          else
            wget -P ~ -O "${note_path}" -q ${sync_url}
            echo 'update success'
          fi
          exit;;
      "version" ) echo "Version: ${version}"
          exit ;;
      "exit" ) exit;;
        * ) echo "不支持的命令"
    esac
done
