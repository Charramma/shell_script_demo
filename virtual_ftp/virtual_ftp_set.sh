#!/bin/bash
# 配置虚拟用户连接ftp

# 创建用于FTP认证的数据库
cat > /etc/vsftpd/vuser.list << EOF
vftpuser1
123456
vftpuser2
123456
EOF

db_load -T -t hash -f /etc/vsftpd/vuser.list /etc/vsftpd/vuser.db
chmod 600 /etc/vsftpd/vuser.db
rm -rf /etc/vsftpd/vuser.list

# 创建存储文件的根目录和虚拟用户映射的本地用户
useradd -d /var/ftproot -s /sbin/nologin vftpuser
chmod -Rf 755 /var/ftproot/

# 创建用于支持虚拟用户的PAM文件
cat > /etc/pam.d/vsftpd.vu << EOF
auth       required     pam_userdb.so db=/etc/vsftpd/vuser
account    required     pam_userdb.so db=/etc/vsftpd/vuser
EOF

# 修改vsftpd配置文件
cat > /etc/vsftpd/vsftpd.conf << EOF
anonymous_enable=NO
local_enable=YES
guest_enable=YES
guest_username=vftpuser
allow_writeable_chroot=YES
write_enable=YES
local_umask=022
dirmessage_enable=YES
xferlog_enable=YES
connect_from_port_20=YES
xferlog_std_format=YES
listen=NO
listen_ipv6=YES
pam_service_name=vsftpd.vu
userlist_enable=YES
tcp_wrappers=YES
user_config_dir=/etc/vsftpd/vusers_dir
EOF

# 为虚拟用户设置权限
mkdir /etc/vsftpd/vusers_dir/
cat > /etc/vsftpd/vusers_dir/vftpuser1 << EOF
anon_upload_enable=YES
anon_mkdir_write_enable=YES
anon_other_write_enable=YES
EOF
touch /etc/vsftpd/vusers_dir/vftpuser2

# 重启vsftpd服务
systemctl restart vsftpd
systemctl enable vsftpd


