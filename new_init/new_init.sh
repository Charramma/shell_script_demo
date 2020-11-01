#!/bin/bash
# AUTHOR: HuangTao（Charramma）
# DATE: 2020-10-31
# DESCRIPTION: 初始化服务器

read -p "此脚本用于初始化服务器操作，是否执行[y/n]: " opt
if [ $opt == "y" ]
then
    # 修改主机名
    echo -e "\033[42;37m ----- 正在执行修改主机名操作 ----- \033[0m"
    read -p "请输入新的主机名：" Hname
    echo "将修改主机名为$Hname"
    hostnamectl set-hostname $Hname
    sleep 1
    echo

    # 添加新用户
    echo -e "\033[42;37m ----- 正在添加新用户并给新用户添加管理员权限 ----- \033[0m"
    useradd Charramma &> /dev/null
    echo Charramma123# | passwd Charramma --stdin  &>/dev/null
    sed -i "100a Charramma    ALL=(ALL)     ALL" /etc/sudoers
    sleep 1
    echo

    # 安装常用软件
    echo -e "\033[42;37m ----- 正在安装常用软件，此过程预计将花费几分钟时间，请继续等待 ----- \033[0m"
    yum install -y epel-release &> /dev/null
    echo "...... (1/9)"
    yum install -y wget &> /dev/null
    echo "...... (2/9)"
    yum install -y vim &> /dev/null
    echo "...... (3/9)"
    yum install -y dos2unix &> /dev/null
    echo "...... (4/9)"
    yum install -y psmisc &> /dev/null
    echo "...... (5/9)"
    yum install -y net-tools &> /dev/null
    echo "...... (6/9)"
    yum install -y lsof &> /dev/null
    echo "...... (7/9)"
    yum install -y telnet &> /dev/null
    echo "...... (8/9)"
    yum install -y tree &> /dev/null
    echo "...... (9/9)"
    echo "所有程序安装完成"
    sleep 1
    echo

    # 关闭NetworkManager
    echo -e "\033[42;37m ----- 正在关闭NetworkManager ----- \033[0m"
    systemctl stop NetworkManager
    sleep 1
    echo

    # 配置YUM源
    echo -e "\033[42;37m ----- 正在配置YUM源 ----- \033[0m"
    cd /etc/yum.repos.d
    wget http://mirrors.163.com/.help/CentOS7-Base-163.repo &> /dev/null
    mv CentOS-Base.repo CentOS-Base.repo.bak
    mv CentOS7-Base-163.repo CentOS-Base.repo
    cd - &>/dev/null
    sleep 1
    echo

    # 关闭防火墙和SELINUX
    echo -e "\033[42;37m ----- 正在关闭防火墙和SELINUX ----- \033[0m"
    systemctl stop firewalld
    systemctl disable firewalld
    setenforce 0
    sed -i "s/SELINUX=enforcing/SELINUX=disabled/" /etc/selinux/config
    sleep 1
    echo

    # 修改ssh配置
    echo -e "\033[42;37m ----- 正在修改ssh配置 ----- \033[0m"
    cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak
    cat >> /etc/ssh/sshd_config <<EOF
### config for sshd for root at $(date +%Y-%m-%d)
Port 2233
PermitRootLogin no
PermitEmptyPasswords no
UseDNS no
### end
EOF
    systemctl restart sshd
    sleep 1
    echo

    # 修改文件描述符数量
    echo -e "\033[42;37m ----- 正在修改文件描述符数量 ----- \033[0m"
    echo "当前文件描述符数量为$(ulimit -n)"
    echo "* - nofile 65535" >> /etc/security/limits.conf
    sleep 1
    echo

    # 设置超时退出
    echo -e "\033[42;37m ----- 正在设置超时退出 ----- \033[0m"
    echo "export TMOUT=300" >> /etc/profile
    source /etc/profile
    sleep 1
    echo

elif [ $opt == "n" ]
then
    exit 1
else
    echo "错误的输入！"
    exit 1
fi

# 退出前提示
read -p "服务器初始化配置完成，是否重启[y/n]" opt
if [ $opt == "y" ]
then
    echo -e "\033[41;37m 服务器将在3秒后重启 \033[0m"
    sleep 3
    reboot
elif [ $opt == "n" ]
then
    echo "如有需要，可使用 reboot 指令手动重启"
    exit 0
else
    echo "错误的输入，退出脚本"
    exit 0
fi
