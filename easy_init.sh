#/bin/bash
# date: 2020-11-8
# author: Charramma
# description: 对个人的linux机器进行简单的配置

# 修改主机名
if [ ! -n "$1" ]; then
	echo -e "\033[41;37m 执行出错，请输入主机名！\033[0m"
	exit 1
else
	# 修改主机名
	hostnamectl set-hostname --static $1
	
	# 创建用户，指定家目录为/Charramma
	useradd -d /Charramma Charramma
	echo Charramma123# | passwd Charramma --stdin
	
	# 创建用户目录
	mkdir -p /Charramma/doc; chown Charramma:Charramma /Charramma/doc
	mkdir -p /Charramma/packet; chown Charramma:Charramma /Charramma/packet
	mkdir -p /Charramma/script; chown Charramma:Charramma /Charramma/script
	
	# 给用户Charramma授权
	sed -i "/^root.*ALL$/a Charramma    ALL=(ALL)    ALL" /etc/sudoers
	
	# 下载常用软件
	yum install epel-release -y
	yum install wget -y
	yum install vim -y
	yum install dos2unix -y
	yum install psmisc -y
	yum install net-tools -y
	yum install lsof -y
	yum install telnet -y
	yum install tree -y
	yum install lrzsz -y
	
	# 给历史命令加上日期和时间
	export HISTTIMEFORMAT="%Y-%m-%d %H:%M:%S  "
	echo 'export HISTTIMEFORMAT="%Y-%m-%d %H:%M:%S  "' >> /etc/profile
	
	# 关闭Linux系统峰鸣
	rmmod pcspkr
	echo "rmmod pcspkr" >> /etc/rc.d/rc.local
	chmod +x /etc/rc.d/rc.local
fi
echo -e "\033[42;37m --------------- SUCCESS! --------------- \033[0m"
