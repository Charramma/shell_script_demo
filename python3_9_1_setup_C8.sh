#!/bin/bash

# 安装依赖
dnf groupinstall 'development tools' -y
dnf install bzip2-devel expat-devel gdbm-devel \
  ncurses-devel openssl-devel readline-devel \
    sqlite-devel tk-devel xz-devel zlib-devel wget -y

# 下载源码包
version=3.9.1
wget -N https://www.python.org/ftp/python/$version/Python-$version.tgz
tar -zxf Python-$version.tgz
cd Python-$version

# 编译安装
./configure --prefix=/usr/local/python39
make -j 2
make install

# 添加安装目录到PATH变量
export PATH=$PATH:/usr/local/python39/bin/
echo "export PATH=$PATH:/usr/local/python39/bin/" >> /etc/profile

# 检验安装
python3 --version
if [[ $? == 0 ]]; then
    echo -e "\033[42;37m Python 3.9.1 安装成功！ \033[0m"
else
    echo -e "\033[41;37m Python 3.9.1 安装失败！ \033[0m"
fi