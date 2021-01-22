#!/bin/bash
# date: 2021-01-22
# author: Charramma
# 公司用的还是CentOS6.7，停止维护后，没法使用yum下载tree，所以写个脚本源码安装

wget http://mama.indstate.edu/users/ice/tree/src/tree-1.8.0.tgz

tar -zxf tree-1.8.0.tgz -C /usr/local
cd /usr/local/tree-1.8.0 && make install