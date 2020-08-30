#!/bin/bash

> up.txt
> down.txt

for i in $(seq 2 254)
do      
        {
        ping 192.168.0.$i -c 1 -w 1
        if (( $? ==  0 ))
        then
                echo 192.168.0.$i is up >> up.txt
        else
                echo 192.168.0.$i is down >> down.txt
        fi
        } &
done
