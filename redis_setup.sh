#!/bin/bash

# 安装依赖
yum install gcc g++ gcc-c++ make  -y

# 升级gcc
yum install centos-release-scl -y
yum install devtoolset-9-gcc devtoolset-9-gcc-c++ devtoolset-9-binutils -y 

# 临时使用gcc9
source /opt/rh/devtoolset-9/enable
# 长期使用gcc9
echo "source /opt/rh/devtoolset-9/enable" >> /etc/profile

# 下载redis 6.0.9源码包
curl -O https://download.redis.io/releases/redis-6.0.9.tar.gz
tar -xzf redis-6.0.9.tar.gz
mv redis-6.0.9 /usr/local/redis
cd /usr/local/redis

# 编译安装
make -j 2
make install

# 解决redis启动的3个警告
echo net.core.somaxconn=511 >> /etc/sysctl.conf
echo vm.overcommit_memory=1 >> /etc/sysctl.conf
sysctl -p
echo never > /sys/kernel/mm/transparent_hugepage/enabled

# 修改redis配置文件
# 允许后台允许
sed -i 's/daemonize no/daemonize yes/' /usr/local/redis/redis.conf
sed -i 's/protected-mode yes/protected-mode no/' /usr/local/redis/redis.conf
echo "requirepass Charramma123#" >> /usr/local/redis/redis.conf

# 启动
cd /usr/local/bin/
./redis-server ../redis/redis.conf