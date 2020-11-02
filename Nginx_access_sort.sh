#!/bin/bash
# author： Charramma huang.zyn@qq.com
# 注：日志文件路径为yum安装的nginx日志文件路径

# 获取nginx访问量
total_access_times=$(cat /var/log/nginx/access.log | awk '{print $1}' | wc -l)

# 获取前五
cat /var/log/nginx/access.log | awk '{print $1}' | sort -nr | uniq -c | awk '{print $1,$2}' | head -n 5