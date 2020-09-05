#!/bin/bash
mkdir -p /backup_tt
cd /backup_tt
if mysql -uttuser -p'ttpasswd' -s /tmp/mysql.sock -e "use tt" 2>/dev/null
then
	for in $(mysql -uttuser -p'ttpasswd' -s /tmp/mysql.sock -e "use tt;show tables;" 2>/dev/null|tail -n +2)
	do
		mysqldump  -uttuser -p'ttpasswd' -s /tmp/mysql.sock   tt $i  >$i.sql
	done
else
	echo "sorry,unkonw database tt"
fi
