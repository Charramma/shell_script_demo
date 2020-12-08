#!/bin/bash

# 安装依赖关系包
yum -y install zlib zlib-devel openssl openssl-devel pcre pcre-devel gcc gcc-c++ autoconf automake make

# 下载安装包
curl -O http://nginx.org/download/nginx-1.19.2.tar.gz

# 新建用来启动nginx的用户
useradd nginx -s /sbin/nologin

# 解压源码包，进入解压后的目录
tar xf nginx-1.19.2.tar.gz
cd nginx-1.19.2

# 编译安装前的配置
./configure --prefix=/usr/local/nginx  --with-http_stub_status_module --with-http_realip_module  --with-http_ssl_module  --with-pcre --with-stream

# 编译安装
make
make install

cd -

# 修改环境变量
export PATH=$PATH:/usr/local/nginx/sbin/
echo 'export PATH=$PATH:/usr/local/nginx/sbin/' >>/etc/profile

# 关闭防火墙
service firewalld stop
systemctl disable firewalld


#启动nginx
nginx

# 设置nginx开机启动
echo 'nginx' >> /etc/rc.d/rc.local
chmod +x /etc/rc.d/rc.local

netstat -ntpl | grep 80
if [[ $? == 0 ]]; then
    echo -e "\033[42;37m *************** nginx安装完成 ***************** \033[0m"
else
    echo -e "\033[41;37m *************** nginx没有开启，请检查一下！***************** \033[0m"
fi