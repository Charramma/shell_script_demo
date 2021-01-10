#!/bin/bash

#关闭防火墙firewalld服务
service firewalld stop &>/dev/null
#设置firewalld服务开机不启动
systemctl  disable firewalld &>/dev/null
#临时关闭selinux
setenforce 0 &>/dev/null
#永久修改selinux配置文件里的内容
sed -i 's/=enforcing/=disabled/g' /etc/selinux/config &>/dev/null