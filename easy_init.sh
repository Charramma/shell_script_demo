#/bin/bash
# date: 2020-11-8
# author: Charramma
# description: 对个人的linux机器进行简单的配置

# 创建用户 指定家目录为/Charramma
useradd -d /Charramma Charramma  &>> /dev/null
echo "---> 创建新用户Charramma ----- (1/6)"
echo Charramma123# | passwd Charramma --stdin  &>> /dev/null
echo "---> 修改新用户Charramma的密码 ----- (2/6)"

# 给这个用户授权
sline=`cat /etc/sudoers | egrep -n "^root" | awk -F : '{print $1}'`
sed -i '${sline}a Charramma    ALL=(ALL)    ALL' /etc/sudoers &>> /dev/null
echo "---> 授予新用户Charramma管理员权限 ----- (3/6)"

# 给用户的家目录中创建几个文件夹
cd /Charramma
mkdir doc; chown Charramma:Charramma doc &>> /dev/null
mkdir packet; chown Charramma:Charramma packet &>> /dev/null
mkdir script; chown Charramma:Charramma script &>> /dev/null
echo "---> 给新用户Charramma的家目录创建常用文件夹 ----- (4/6)"

# 下载一些常用的软件
echo "---> 安装常用软件 ----- (5/6)"

echo "    -> Downloading epel-release"
yum install -y epel-release &> /dev/null
echo "    -- epel-release installed successfully (1/10)"

echo "    -> Downloading wget"
yum install -y wget &> /dev/null
echo "    -- wget installed successfully (2/10)"

echo "    -> Downloading vim"
yum install -y vim &> /dev/null
echo "    -- vim installed successfully (3/10)"

echo "    -> Downloading dos2unix"
yum install -y dos2unix &> /dev/null
echo "    -- dos2unix installed successfully (4/10)"

echo "    -> Downloading psmisc"
yum install -y psmisc &> /dev/null
echo "    -- psmisc installed successfully (5/10)"

echo "    -> Downloading net-tools"
yum install -y net-tools &> /dev/null
echo "    -- net-tools installed successfully (6/10)"

echo "    -> Downloading lsof"
yum install -y lsof &> /dev/null
echo "    -- lsof installed successfully (7/10)"

echo "    -> Downloading telnet"
yum install -y telnet &> /dev/null
echo "    -- telnet installed successfully (8/10)"

echo "    -> Downloading tree"
yum install -y tree &> /dev/null
echo "    -- tree installed successfully (9/10)"

echo "    -> Downloading lrzsz"
yum install -y lrzsz &> /dev/null
echo "    -- lrzsz installed successfully (10/10)"

# 修改主机名
hostnamectl set-hostname Charramma
echo "---> 修改主机名 ----- (6/6)"