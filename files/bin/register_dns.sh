#!/bin/bash

SERIAL=`cat /proc/cpuinfo |grep -i serial |awk '{print $3}'`
ADDR=`ip a |grep eth0 |grep inet |awk '{print $2}' |awk -F'/' '{print $1}'`
docker run -it --env-file=/etc/registerer/env takutakahashi/route53-registerer ${SERIAL:8}.lab.takutakahashi.dev A $ADDR
