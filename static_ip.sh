#!/bin/bash
# date: 2020-11-8
# author: Charramma(Huang)
# description: 简单的给我的虚拟机配置静态ip地址
# -------------------------------------------

ipaddr=$(ip a | grep -w inet | awk '{print $2}' | awk -F / '{print $1}' | sed -n '2p')
gateway=192.168.$(echo $ipaddr | awk -F . '{print $3}').1

cp /etc/sysconfig/network-scripts/ifcfg-ens33 /etc/sysconfig/network-scripts/ifcfg-ens33.bak

cat > /etc/sysconfig/network-scripts/ifcfg-ens33 << EOF
BOOTPROTO="none"
NAME="ens33"
DEVICE="ens33"
ONBOOT="yes"
IPADDR=$ipaddr
PREFIX=24
GATEWAY=$gateway
DNS1=114.114.114.114
EOF

systemctl stop NetworkManager
systemctl disable NetworkManager

systemctl restart network