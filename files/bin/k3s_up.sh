#!/bin/bash -xe

K3S_OPTS="--datastore-endpoint=`cat /etc/db` --node-taint k3s-controlplane=true:NoExecute --no-deploy traefik"
ls /bin/k3s && ls /var/lib/rancher/k3s && k3s server $K3S_OPTS
apt install -y dnsutils netcat
rm -f /bin/k3s
wget "https://github.com/rancher/k3s/releases/download/v1.17.5%2Bk3s1/k3s-armhf" -O /bin/k3s
chmod +x /bin/k3s
host=k8s.lab.takutakahashi.dev
for i in 1 2 3 4 5
do
  echo exit |nc -w 10 $host 6443 && ( K3S_TOKEN=`dig +short TXT ${host} | sed 's/"//g'` k3s server --server https://${host}:6443 $K3S_OPTS) || true
done

register_secret.sh &
k3s server --cluster-init --tls-san k8s.lab.takutakahashi.dev $K3S_OPTS
