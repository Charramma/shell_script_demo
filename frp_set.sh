#!/bin/bash

# get type
read -p "Input the type(frps or frpc?):  " opt

# global vars
version='0.36.2'
path='/usr/local'
type=$opt
server_ip=48.199.172.22
server_port=7000
client_ip=192.168.2.45
client_port=6000
client_ssh_port=22
connect_name='ssh'


wget https://github.com/fatedier/frp/releases/download/v0.36.2/frp_${version}_linux_amd64.tar.gz

tar -zxf frp_${version}_linux_amd64.tar.gz -C ${path}
mv ${path}/frp_${version}_linux_amd64 ${path}/frp


cd ${path}/frp

if [[ $type == 'frps' ]]; then
    ls | grep -Ewv "frps|frps.ini" | xargs rm -rf
    cat > ${path}/frp/frps.ini << EOF
[common]
bind_port=${server_port}
EOF
    nohup ${path}/frp/frps -c ${path}/frp/frps.ini >> ${path}/frp/nohup.out 2>&1 &

elif [[ $type == 'frpc' ]]; then
    ls | grep -Ewv "frpc|frpc.ini" | xargs rm -rf
    cat > ${path}/frp/frpc.ini << EOF
[common]
server_addr=${server_ip}
server_port=${server_port}

[${connect_name}]
type=tcp
local_ip=${client_ip}
local_port=${client_ssh_port}
remote_port=${client_port}
EOF
    nohup ${path}/frp/frpc -c ${path}/frp/frpc.ini >> ${path}/frp/nohup.out 2>&1 &

else
    echo "INPUT ERROR!"
fi


