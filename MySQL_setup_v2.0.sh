#!/bin/bash

#############################
# 编译安装mysql 5.7.29
# os: CentOS 7
# MySQL版本：5.7.29
# author: 	HuangTao
# time: 	2020-6-6
# email: 	huang.zyn@qq.com
#############################

echo '#################################################'
echo '开始安装MySQL'

# 下载依赖包
yum install cmake ncurses-devel gcc gcc-c++ bzip2 openssl-devel wget -y

# 新建一个无家目录且禁止登录的用户mysql，这个用户是linux系统用来启动MySQL的。
useradd -M -s /sbin/nologin mysql
# 新建一个给MySQL存放数据的目录
mkdir -p /data/mysql
# 修改数据目录的属主为mysql用户
chown mysql:mysql /data/mysql

# 下载源码包
wget https://downloads.mysql.com/archives/get/p/23/file/mysql-community-5.7.29-1.el7.src.rpm
# 解压源码包
rpm -ivh mysql-community-5.7.29-1.el7.src.rpm
# 进入存放真正源码包的目录
cd /root/rpmbuild/SOURCES
# 解压mysql-5.7.29.tar.gz，就是源码所在的压缩包。还有一个boost_1_59_0.tar.bz2包，Boost是为C++语言标准库提供扩展的一些C++程序库的总称。
tar -xf mysql-5.7.29.tar.gz
tar -xf boost_1_59_0.tar.bz2 -C mysql-5.7.29

# 进入解压后的mysql包
cd mysql-5.7.29


#进行编译前的配置
cmake -DCMAKE_INSTALL_PREFIX=/usr/local/mysql -DMYSQL_DATADIR=/data/mysql  -DSYSCONFDIR=/etc  -DMYSQL_USER=mysql  -DDEFAULT_CHARSET=utf8 -DDEFAULT_COLLATION=utf8_general_ci  -DWITH_BOOST=boost_1_59_0

# 编译安装
make -j 2 && make install

# 备份，并清空配置文件
cp /etc/my.cnf /root/mysql.cnf.bak	&>/dev/null
>/etc/my.cnf

# 重置配置文件
cat >/etc/my.cnf << EOF
[mysqld_safe]
log-error=/var/log/mysql/mysql.log

[client]
socket=/tmp/mysql.sock

[mysqld]
socket=/tmp/mysql.sock
port = 3306
open_files_limit = 8192
innodb_buffer_pool_size = 512M

[mysql]
auto-rehash
prompt=\\u@\\d \\R:\\m  mysql>
EOF

# 创建MySQL日志文件目录
mkdir -p /var/log/mysql
chown mysql:mysql /var/log/mysql

# 初始化MySQL
# 进入编译安装好的mysql的目录（安装目录）
cd /usr/local/mysql/bin
# 执行mysqld这个程序，初始化mysql，并且将日志和临时密码重定向到/root/temp_password.txt文件里
./mysqld --initialize  --user=mysql --basedir=/usr/local/mysql/  --datadir=/data/mysql  &>/root/temp_password.txt

# 将新的PATH变量重定向到/etc/bashrc文件（下次开机生效）
echo "export PATH=$PATH:/usr/local/mysql/bin" >> /etc/profile
# 刷新环境变量
#source /etc/bashrc
PATH=$PATH:/usr/local/mysql/bin

# 拷贝mysqld的程序文件到指定的目录，方便后面设置mysqld服务开机启动。
\cp /usr/local/mysql/support-files/mysql.server /etc/init.d/mysqld

# 设置开机启动MySQL
chkconfig --add mysqld
# 启动MySQL
service mysqld start

#从保存的临时密码文件里，截取出临时密码，赋值给一个变量temp_pwd
temp_pwd=`cat /root/temp_password.txt  | tail -1 | awk '{print $NF}'`
#给MySQL设置密码为Charramma123#
mysql -uroot -p$temp_pwd  --connect-expired-password -e "set password='Charramma123#'"

mysql --version > /dev/null
if [[ $? == 0 ]]; then
    echo '###### congratulation! your mysql has be installed successfully ######'
fi
