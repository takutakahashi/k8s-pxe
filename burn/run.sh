#!/bin/bash

apt update
apt install git -y
git clone https://github.com/takutakahashi/k8s-pxe.git /tmp/pxe
cd /tmp/pxe/burn
cp bin/* /bin/
cp etc/systemd/system/startup.service /etc/systemd/system/startup.service
cd etc/systemd/system/multi-user.target.wants/
systemctl enable startup
systemctl start startup
