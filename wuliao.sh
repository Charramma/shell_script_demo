#!/bin/bash
# 一个无聊的脚本

count=0
clear
while (($count<20))
do
	count=$count+1
	if ((count%4==0)); then
		echo "|"
		sleep 1
		clear
	elif ((count%4==1)); then
		echo "/"
		sleep 1
		clear
	elif ((count%4==2)); then
		echo "—"
		sleep 1
		clear
	elif ((count%4==3)); then
		echo "\\"
		sleep 1
		clear
	fi
done