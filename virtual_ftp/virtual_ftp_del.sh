#!/bin/bash
# 删除虚拟用户配置

rm -rf /etc/vsftpd/vuser.db

userdel -r vftpuser

rm -rf /etc/pam.d/vsftpd.vu

\cp /etc/vsftpd/vsftpd.conf.bak /etc/vsftpd/vsftpd.conf

rm -rf /etc/vsftpd/vusers_dir/

systemctl restart vsftpd