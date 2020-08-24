#!/bin/bash

# 安装依赖关系包
yum -y install zlib zlib-devel openssl openssl-devel pcre pcre-devel gcc gcc-c++ autoconf automake make &>/dev/null

# 下载安装包
curl -O http://nginx.org/download/nginx-1.19.2.tar.gz

# 新建用来启动nginx的用户
useradd nginx -s /sbin/nologin

# 解压源码包，进入解压后的目录
tar xf nginx-1.19.2.tar.gz
cd nginx-1.19.2

# 编译安装前的配置
./configure --prefix=/usr/local/nginx --user=nginx --with-http_realip_module  --with-http_ssl_module  --with-pcre

# 编译安装
make
make install

cd -

# 修改环境变量
echo 'PATH=$PATH:/usr/local/nginx/sbin/' >>/etc/bashrc
source /etc/bashrc

# 关闭防火墙
service firewalld stop
systemctl disable firewalld

# 设置service方式启动nginx
cat > /usr/lib/systemd/system/nginx.service <<EOF
[Unit]

Description=The nginx HTTP and reverse proxy server

After=network.target remote-fs.target nss-lookup.target

[Service]

Type=forking

PIDFile=/usr/local/nginx/logs/nginx.pid

# Nginx will fail to start if /run/nginx.pid already exists but has the wrong

# SELinux context. This might happen when running nginx -t from the cmdline.

# https://bugzilla.redhat.com/show_bug.cgi?id=1268621

ExecStartPre=/usr/bin/rm -f /usr/local/nginx/logs/nginx.pid

ExecStartPre=/usr/local/nginx/sbin/nginx -t

ExecStart=/usr/local/nginx/sbin/nginx

ExecReload=/bin/kill -s HUP $MAINPID

KillSignal=SIGQUIT

TimeoutStopSec=5

KillMode=mixed

PrivateTmp=true

[Install]

WantedBy=multi-user.target
EOF

# 重新加载服务的配置文件
systemctl daemon-reload

#启动nginx
service nginx start

# 设置nginx开机启动
systemctl enable nginx.service

echo '*************** nginx安装完成 *****************'