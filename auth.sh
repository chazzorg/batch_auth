#!/bin/bash

echo '******  批量自动同步密钥脚本 ******:'

file=$1
if [ ! -e "$file" ]; then
    echo -e "\033[31m 请选择配置文件!!!!!!!!! \033[0m"
    exit
fi

if [ ! -f ~/.ssh/id_rsa.pub ];then
echo "开始创建本机密钥"
ssh-keygen -t rsa -N '' -f ~/.ssh/id_rsa -q
fi

while read line;do
	ip=`echo $line | cut -d " " -f1`
	echo $ip "准备同步"
done < $file

while read line;do
    ip=`echo $line | cut -d " " -f1`
    user_name=`echo $line | cut -d " " -f2`
    pass_word=`echo $line | cut -d " " -f3`
expect <<EOF
    spawn ssh-copy-id $user_name@$ip
    expect {
    "yes/no" { send "yes\n";exp_continue}
    "password" { send "$pass_word\n"}
    }
    expect eof
EOF
sleep 1
done < $file

while read line;do
    ip=`echo $line | cut -d " " -f1`
    user_name=`echo $line | cut -d " " -f2`
    pass_word=`echo $line | cut -d " " -f3`
    my_host=`awk '{print $3}' ~/.ssh/id_rsa.pub`
    ssh $user_name@$ip "grep "$my_host" ~/.ssh/authorized_keys" < /dev/null >&/dev/null
    if [ $? -eq 0 ]; then
            echo -e "\033[32m $ip is ok \033[0m"
    else
            echo -e "\033[31m $ip is not ok \033[0m"
    fi
done < $file

echo -e "\033[32m ******  脚本执行完毕 ****** \033[0m"
