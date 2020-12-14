# 编写的一些shell脚本
- **MySQL_setup.sh**  编译安装MySQL 5.7.29

- **MySQL_setup_v2.0.sh**  编译安装MySQL 5.7.29（优化版）

- **Nginx_setup.sh**  编译安装Nginx 1.19.2

- **nginx_setup_v2.0s.sh**  编译安装Nginx 1.19.2（简化版）

- **nginx_setup_v3.0s.sh**  编译安装Nginx 1.19.2（在第一版的基础上删除service文件，使用原生服务开启关闭方式）

- **parted_partition.sh**  使用parted分区

- **fdisk_partition.sh**  使用fdisk分区

- **ipcheck_v1.sh** 检测局域网（0网段）中哪些ip可用

- **tt_mysqldump.sh**

    检测mysql是否存在名称为tt的数据库，若存在，请将tt库下的每个表都独立到一份以<表名.sql>为文件名的sql，放在当前目录下，请写出命令。
    （相关信息：本地库127.0.0.1或者localhost，端口3306，sock：/tmp/mysql.sock，账号：ttuser 密码：ttpasswd）

- **new_init** 给我自己新装的虚拟机进行初始化配置的脚本

- **redis_setup.sh** 编译安装redis 6.0.9

- **easy_init.sh** 对我自己的linux系统进行简单的配置

- **static_ip.sh** 对我自己的虚拟机进行静态ip配置

- **virtual_ftp** 配置虚拟用户连接ftp

    **virtual_ftp_set.sh** 配置虚拟用户

    **virtual_ftp_del.sh** 删除virtual_ftp_set.sh的配置

- **wuliao.sh** 一个无聊的脚本

- **welcome.sh** 输出一个ASCII字符CHARRAMMA，给予可执行权限，然后写到/etc/profile中，每次打开终端就会执行，作为一个欢迎界面

- **netspeed_check.sh** 简单的网速测试脚本，只能测试上传速度和下载速度

- **ip_change.sh** 配置静态ip

- **nfsserver_build.sh** nfs服务端配置脚本，根据需求对配置进行修改

- **python3_9_1_setup_C7.sh** CentOS 7 环境下编译安装Python3.9.1，安装路径在/usr/local/python39/

- **python3_9_1_setup_C8.sh**  CentOS 8 环境下编译安装Python3.9.1，安装路径在/usr/local/python39/