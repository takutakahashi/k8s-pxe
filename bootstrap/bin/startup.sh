#!/bin/bash

apt update -y
apt install -y git
git clone https://github.com/takutakahashi/k8s-pxe.git /tmp/pxe
cd /tmp/pxe/files
find . -type f |xargs -I{} mv {} /{}
/bin/provision.sh
