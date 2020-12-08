#!/bin/bash

# 关闭防火墙
iptables -F
service firewalld stop
systemctl disable firewalld
setenforce 0
sed -i "s/^SELINUX=.*/SELINUX=disabled/" /etc/selinux/config

# 下载安装服务
yum install nfs-utils rpcbind -y

# 启动服务
systemctl start rpcbind.service
systemctl start nfs.service

# 设置开机自启动
systemctl start rpcbind.service
systemctl start nfs.service

# 创建挂载目录及文件
mkdir -p /nfs/test/
echo hello > /nfs/test/test.txt

echo "/nfs/test/ 192.168.1.0/24(rw,sync)" >> /etc/exports


exportfs -rv

showmount -e localhost