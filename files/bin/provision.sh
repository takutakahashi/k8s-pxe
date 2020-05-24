#!/bin/bash

### set hostname ###
SERIAL=`cat /proc/cpuinfo |grep -i serial |awk '{print $3}'`
hostname ${SERIAL:8}.lab.takutakahashi.dev

### docker install ###
apt update -y
apt install -y docker.io

### register DNS record ###
/bin/register_dns.sh

### k3s up ###
/bin/k3s_up.sh
