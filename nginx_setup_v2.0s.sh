#!/bin/bash

#安装必要的软件，解决依赖关系
yum install  gcc  pcre-devel  openssl-devel make  -y

#download nginx
curl -O http://nginx.org/download/nginx-1.19.2.tar.gz

#解压
tar xf nginx-1.19.2.tar.gz
#进入文件夹
cd nginx-1.19.2
#编译前的配置
./configure --prefix=/usr/local/nginx2   --with-http_realip_module  --with-http_ssl_module  --with-pcre --with-stream


#编译
make
#安装
make  install

#修改PATH变量
echo "PATH=/usr/local/nginx2/sbin/:$PATH" >>/etc/bashrc

#修改配置文件
sed -i '36c listen  8080;' /usr/local/nginx2/conf/nginx.conf

#启动nginx
/usr/local/nginx2/sbin/nginx

#开机启动
echo  "/usr/local/nginx2/sbin/nginx" >>/etc/rc.local
chmod +x /etc/rc.d/rc.local
