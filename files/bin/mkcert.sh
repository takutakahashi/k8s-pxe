#!/bin/bash
wget -O /bin/mkcert https://github.com/FiloSottile/mkcert/releases/download/v1.4.1/mkcert-v1.4.1-linux-arm
chmod +x /bin/mkcert
mkcert -install
srv2ip.sh _etcd-client-ssl._tcp.lab.takutakahashi.dev |xargs mkcert -cert-file /etc/etcd/certs/server.crt -key-file /etc/etcd/certs/cerver.key lab.takutakahashi.dev "*.lab.takutakahashi.dev"
