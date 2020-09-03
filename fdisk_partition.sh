#!/bin/bash

# 判断磁盘是否已经进行了分区
if (( $(fdisk -l /dev/sde | grep "^/dev/sde" | wc -l) > 0 ))
then
	echo "这块磁盘已经进行分区，请管理员进行检查"
	exit
else
	echo "开始进行分区操作"
	sleep 3
fi

# 分区
fdisk /dev/sde <<EOF
p
n
1
2048
+30G
p
n
2
62916608
+20G
w
EOF

echo "##############分区完成#######################"
fdisk -l /dev/sde
echo "##############################################"

# 格式化
for i in $(ls /dev/sde?)
do
	mkfs.xfs $i
done

# 挂载
mkdir -p /movie
mkdir -p /photo
mount /dev/sde1 /movie
mount /dev/sde2 /photo

# 开机自动挂载
echo "dev/sde1 /movie xfs defaults 0 0" >> /etc/fstab
echo "dev/sde2 /photo xfs defaults 0 0" >> /etc/fstab