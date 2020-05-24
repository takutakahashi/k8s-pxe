#!/bin/bash -xe

apt update -y
apt install -y git
git clone https://github.com/takutakahashi/k8s-pxe.git /tmp/pxe
cd /tmp/pxe/files
find . -type f |xargs -I{} mv {} /{}
cd etc/systemd/system
find . -type f |xargs -I{} ln -s /etc/systemd/system/{} /etc/systemd/system/multi-user.target.wants/{}
/bin/provision.sh
