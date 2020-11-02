#!/bin/bash
# DATE: 2020-11-2
# AUTHOR: Charramma(Huang)
# DESCRIPTION: 编译安装redis
# ++++++++++++++++++++++++++++++++++

# 安装依赖
yum install gcc g++ gcc-c++ make  -y
# 升级gcc
yum install centos-release-scl -y
yum install devtoolset-9-gcc devtoolset-9-gcc-c++ devtoolset-9-binutils -y
# 临时启用gcc9
scl enable devtoolset-9 bash
# 长期使用gcc9
echo "source /opt/rh/devtoolset-9/enable" >> /etc/profile

# 下载redis 6.0.9源码包
curl -O https://download.redis.io/releases/redis-6.0.9.tar.gz
tar -xvf redis-6.0.9.tar.gz
cd redis-6.0.9

# 编译安装
make 
make install PREFIX=/usr/local/redis

# 修改PATH变量
export PATH=$PATH:/usr/local/redis/bin
echo "PATH=$PATH:/usr/local/redis/bin" > /etc/profile

# 解决redis启动的3个警告
echo net.core.somaxconn=511 >> /etc/sysctl.conf
echo vm.overcommit_memory=1 >> /etc/sysctl.conf
sysctl -p
echo never > /sys/kernel/mm/transparent_hugepage/enabled

# 修改redis配置文件
sed -i 's/daemonize no/daemonize yes/' /usr/local/redis/redis.conf
sed -i 's/bind 127.0.0.1/#bind 127.0.0.1/' /usr/local/redis/redis.conf
sed -i 's/protected-mode yes/protected-mode no/' /usr/local/redis/redis.conf
echo "requirepass Charramma123#" >> /usr/local/redis/redis.conf

# 启动
cd /usr/local/redis/bin/
./redis-server ../redis.conf