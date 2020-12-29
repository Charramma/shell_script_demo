#!/bin/bash
# Date: 2020-12-14
# Author: Charramma(Huang)
# Description: CentOS 7 编译安装Python 3.9.1

# 安装编译所需要的工具包
yum install epel-release -y
yum install wget make -y
# 安装依赖
yum install gcc patch libffi-devel python-devel zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel gdbm-devel db4-devel libpcap-devel xz-devel -y

# 下载python 3.9.1的源码包
version=3.9.1
wget -N https://www.python.org/ftp/python/${version}/Python-${version}.tgz
#解压
tar -xzf Python-${version}.tgz
cd Python-${version}

# 编译安装三部曲
./configure --prefix=/usr/local/python39/
make -j2
make install

# 添加安装目录到PATH变量
export PATH=$PATH:/usr/local/python39/bin/
echo "export PATH=$PATH:/usr/local/python39/bin/" >> /etc/profile

# 配置pip国内源
mkdir -p ~/.pip
cat > ~/.pip/pip.conf << EOF
[global]
time-out=60
index-url = https://pypi.tuna.tsinghua.edu.cn/simple/

[install]
trusted-host=tsinghua.edu.cn
EOF

# 检验安装
python3 --version
if [[ $? == 0 ]]; then
    echo -e "\033[42;37m Python 3.9.1 安装成功！ \033[0m"
else
    echo -e "\033[41;37m Python 3.9.1 安装失败！ \033[0m"
fi
