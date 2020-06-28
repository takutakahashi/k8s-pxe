#!/bin/bash

### set hostname ###
SERIAL=`cat /proc/cpuinfo |grep -i serial |awk '{print $3}'`
hostname ${SERIAL:8}.lab.takutakahashi.dev

### enable ssh ###
systemctl enable ssh
mkdir /home/pi/.ssh
curl https://github.com/takutakahashi.keys > /home/pi/.ssh/authorized_keys
chown pi:pi -R /home/pi/.ssh
chmod 644 /home/pi/.ssh/authorized_keys

### docker install ###
apt update -y
apt install -y docker.io

### register DNS record ###
/bin/register_dns.sh

### etcd up ###
systemctl daemon-reload
systemctl enable etcd
systemctl restart etcd
### k3s up ###
systemctl daemon-reload
systemctl enable k3s
systemctl restart k3s
