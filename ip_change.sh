#!/bin/bash
# Date: 2020-12-7
# Author: Charramma(Huang)
# Description: 配置静态ip，需要手动输入ip

read -p "输入网卡名：" device
read -p "输入静态ip：" ip
gateway=`echo $ip | cut -d "." -f 1-3`.1

# 测试ip是否被占用
cur_ip=`ifconfig | egrep -A 1  ".*$device.*" | grep -w inet | awk '{print $2}'`
ping $ip -w 1 -c 1 &> /dev/null
if [[ $? == 0 ]] && [[ $ip != $cur_ip ]]; then
    echo -e "\033[41;37m 此ip已被占用 \033[0m"
    exit 1
fi

# 修改网络脚本
sed -i "/^IPADDR=.*/d" "/etc/sysconfig/network-scripts/ifcfg-$device"
sed -i "/^GATEWAY=.*/d" "/etc/sysconfig/network-scripts/ifcfg-$device"
sed -i "/^PREFIX=.*/d" "/etc/sysconfig/network-scripts/ifcfg-$device"
sed -i "/^DNS.*/d" "/etc/sysconfig/network-scripts/ifcfg-$device"

sed -i 's/^BOOTPROTO=.*/BOOTPROTO="none"/' "/etc/sysconfig/network-scripts/ifcfg-$device"
echo "IPADDR=$ip" >> "/etc/sysconfig/network-scripts/ifcfg-$device"
echo "PREFIX=24" >> "/etc/sysconfig/network-scripts/ifcfg-$device"
echo "GATEWAY=$gateway" >> "/etc/sysconfig/network-scripts/ifcfg-$device"
echo "DNS1=$gateway" >> "/etc/sysconfig/network-scripts/ifcfg-$device"
echo "DNS2=114.114.114.114" >> "/etc/sysconfig/network-scripts/ifcfg-$device"

# 重启服务
systemctl stop NetworkManager
systemctl disable NetworkManager
service network restart
