#!/bin/bash
# date: 2021-02-01
# 用于CentOS 6系统更换可用yum源（阿里）

sed -i "s/enabled=1/enabled=0/" /etc/yum/pluginconf.d/fastestmirror.conf

mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.bak

curl /etc/yum.repos.d/CentOS-Base.repo https://static.lty.fun/%E5%85%B6%E4%BB%96%E8%B5%84%E6%BA%90/SourcesList/Centos-6-Vault-Aliyun.repo > /etc/yum.repos.d/CentOS-Base.repo