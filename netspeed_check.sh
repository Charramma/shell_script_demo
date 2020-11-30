#!/bin/bash
# @Author: Charramma
# @Date: 2020-11-30
# @Description: 简单的网速检测脚本

# 需要先下载git
which git > /dev/null
if [[ $? != 0 ]]; then
    yum install git -y > /dev/null
else
    # 要到git上拉取一个测速工具
    ls /usr/local/speedtest-cli/ > /dev/null
    if [[ $? != 0 ]]; then
        cd /usr/local
        git clone https://github.com/sivel/speedtest-cli.git >/dev/null
    fi
    
    cd /usr/local/
    downspeed=`./speedtest-cli/speedtest.py | tail -3 | head -1`
    upspeed=`./speedtest-cli/speedtest.py | tail -1`

    # 打印结果——日期、上传速度、下载速度
    date +%Y_%m_%d_%T
    echo $upspeed
    echo $downspeed
fi
