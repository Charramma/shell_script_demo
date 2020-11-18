#!/bin/bash
# description: 关闭Linux系统的蜂鸣声

# 临时关闭，立即生效
rmmod pcspkr
# 永久关闭，重启生效
echo "rmmod pcspkr" >> /etc/rc.d/rc.local
chmod +x /etc/rc.d/rc.local