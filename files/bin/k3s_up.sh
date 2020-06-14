#!/bin/bash -xe
HOSTNAME=`hostname`
IP=`dig +short $HOSTNAME`
K3S_OPTS="--datastore-endpoint=`cat /etc/db` --node-taint k3s-controlplane=true:NoExecute --no-deploy traefik --tls-san k8s.lab.takutakahashi.dev --tls-san 127.0.0.1 --tls-san $HOSTNAME --tls-san $IP"
ls /bin/k3s && ls /var/lib/rancher/k3s && k3s server $K3S_OPTS
apt install -y dnsutils netcat
rm -f /bin/k3s
wget "https://github.com/rancher/k3s/releases/download/v1.17.5%2Bk3s1/k3s-armhf" -O /bin/k3s
chmod +x /bin/k3s
register_secret.sh &
k3s server $K3S_OPTS
